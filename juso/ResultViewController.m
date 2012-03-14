//
//  ResultViewController.m
//  juso
//
//  Created by jungho jang on 12. 1. 16..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "ResultViewController.h"
#import "TBXML.h"
#import "Annotation.h"
#import "SetColor.h"
@implementation ResultViewController

@synthesize receiveData = _receiveData;
@synthesize connection = _connection;
@synthesize item = _item;
@synthesize address1 = _address1;
@synthesize address2 = _address2;
@synthesize zipcode = _zipcode;
@synthesize resultPosition = _resultPosition;
@synthesize locationManger = _locationManger;
@synthesize addressPoint = _addressPoint;
@synthesize mPlacemark = _mPlacemark;
@synthesize coordinate;
@synthesize mapView = _mapView;

static NSString *goole_api_key = @"0bpdlAngqAMTbn5AV99pYjooL2-Ir276KNBtKHA";


-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:saveFile];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *taddress1 = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ %@",
                           self.item.sido,self.item.gugun,self.item.dong,self.item.lot_num,self.item.lot_sub_num,self.item.bldg_name];
    
    NSString *taddress2 = [[NSString alloc] init];
    
    if ([self.item.bldg_sub_num intValue]>0) {
        taddress2 = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ (%@)",self.item.sido,self.item.gugun,self.item.road_name,self.item.bldg_num,self.item.bldg_sub_num,self.item.dong_name];
    }else {
        taddress2 = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@ (%@)",self.item.sido,self.item.gugun,self.item.road_name,self.item.bldg_num,self.item.dong_name];
    }
    
    NSString *zipcode = [[NSString alloc] initWithFormat:@"[%@]",self.item.zipcode];
    
    self.address1.text = taddress1;
    self.address2.text = taddress2;
    self.zipcode.text = zipcode;

    
    //[self requestPosition];
    [self setPosition];
    //NSLog(@"%f %f",[self.item.longitude floatValue],[self.item.latitude floatValue]);
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //MapKit
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = NO;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.mapType = MKMapTypeStandard;
    
    self.locationManger = [[CLLocationManager alloc] init];
    self.locationManger.delegate = self;
    self.locationManger.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManger.distanceFilter = 2000.0f;

    self.resultPosition = [[NSString alloc] init];
    
    SetColor *color = [[SetColor alloc] init];
    [self.view setBackgroundColor:[color getColor:250 gColor:231 bColor:214]];
    
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setZipcode:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setItem:nil];
    [self setAddress1:nil];
    [self setAddress2:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)closeView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)saveAddress:(id)sender {
    
    NSString *filePath = [self dataFilePath];

    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:self.address1.text forKey:@"oldAddress"];
    [dict setValue:self.address2.text forKey:@"newAddress"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
        [data addObject:dict];
        [data writeToFile:[self dataFilePath] atomically:YES];
        
    }else{
        NSMutableArray *data = [[NSMutableArray alloc] init];
        [data addObject:dict];
        [data writeToFile:[self dataFilePath] atomically:YES];
    }
                                     
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"즐겨찾기에 추가 하였습니다"
                                                   delegate:self
                                          cancelButtonTitle:@"확인"
                                          otherButtonTitles:nil];
    [alert show];
    
}

- (IBAction)sendSMS:(id)sender {
    NSLog(@"sms");
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    //controller.messageComposeDelegate = self;
    NSLog(@"%@",self);
    if ([MFMessageComposeViewController canSendText]) {
        NSString *adr = [[NSString alloc] initWithFormat:@"도로명주소\n%@",self.address2.text];
        controller.body = adr;
        //cont.recipients = [NSArray arrayWithObjects:@"010-4296-2222", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }
    
}

- (IBAction)copyAddress:(id)sender {
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    NSString *nAddr= [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ (%@)",self.item.sido,self.item.gugun,self.item.road_name,self.item.bldg_num,self.item.bldg_sub_num,self.item.dong_name];
    paste.string = nAddr;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"도로명주소를 복사하였습니다"
                                                   delegate:self
                                          cancelButtonTitle:@"확인"
                                          otherButtonTitles:nil];
    [alert show];
}



-(void)requestPosition
{
    
    NSString *url = [[NSString alloc] init];
    url = [[NSString stringWithFormat:@"http://maps.google.co.kr/maps/geo?q=%@&output=xml&sensor=true&key=%@",
            self.address1.text,goole_api_key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    if (self.connection) {
        self.receiveData = [[NSMutableData alloc] init];
    }
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}


#pragma mark - HTTPRequest

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.receiveData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
	//NSString *str = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
    //NSLog(@"%s",[self.receiveData bytes]);
    
    
    TBXML *tbxml = [[TBXML alloc] initWithXMLData:self.receiveData];
    TBXMLElement *root = tbxml.rootXMLElement;
    
    if(root !=nil)
    {
        
        TBXMLElement *newEntry = [TBXML childElementNamed:@"Response" parentElement:root];
        while(newEntry != nil)
        {
            
            TBXMLElement *placemark = [TBXML childElementNamed:@"Placemark" parentElement:newEntry];
            while (placemark!=nil) {
                TBXMLElement *point = [TBXML childElementNamed:@"Point" parentElement:placemark];
                while (point!=nil) {
                    TBXMLElement *pos = [TBXML childElementNamed:@"coordinates" parentElement:point];
                    
                    self.resultPosition = [TBXML textForElement:pos];
                    point = [TBXML nextSiblingNamed:@"Point" searchFromElement:point];
                }
                
                
                placemark = [TBXML nextSiblingNamed:@"Placemark" searchFromElement:placemark];
            }
    
            
            newEntry = [TBXML nextSiblingNamed:@"Response" searchFromElement:newEntry];
        }
        

    }
    
    [self setPosition];
    return;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	//NSLog(@"Receive : %@, %@, %d",[response URL], [response MIMEType], [response expectedContentLength]);
}

#pragma mark - 

-(void)setPosition
{
    float longitude = [self.item.longitude floatValue];
    float latitude = [self.item.latitude floatValue];
    
    MKCoordinateRegion addrPosition;
    CLLocationCoordinate2D center;
    MKCoordinateSpan span;
    
    center.longitude = longitude;
    center.latitude = latitude;
    
    span.latitudeDelta = 0.003;
    span.longitudeDelta = 0.003;
    
    addrPosition.center = center;
    addrPosition.span = span;
    
    [self.mapView setRegion:addrPosition animated:NO];
    //[self.mapView setCenterCoordinate:self.mapView.region.center animated:YES];
    
    
    NSString *addr1 = [[NSString alloc] initWithFormat:@"%@ %@ %@",self.item.sido,self.item.gugun,self.item.dong];
    
    NSString *addr2 = [[NSString alloc] initWithFormat:@"%@-%@ %@",self.item.lot_num,self.item.lot_sub_num,self.item.bldg_name];
    
    Annotation *pos1 = [[Annotation alloc] init];
    pos1.coordinate = center;
    pos1.title = addr1;
    pos1.subtitle = addr2;
    
    [self.mapView addAnnotation:pos1];
    
}

#pragma mark -

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultSent:
            //NSLog(@"send");
            break;
        case MessageComposeResultCancelled:
            //NSLog(@"cancel");
            break;
        default:
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}



@end
