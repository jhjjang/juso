//
//  MultiResultViewController.m
//  juso
//
//  Created by jungho jang on 12. 1. 20..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "MultiResultViewController.h"
#import "TBXML.h"
#import "Annotation.h"
#import "CustomCell.h"
#import "SetColor.h"

@implementation MultiResultViewController
@synthesize toolbarTitle;

@synthesize receiveData = _receiveData;
@synthesize connection = _connection;
@synthesize addressObjects = _addressObjects;
@synthesize addr = _addr;
@synthesize address1 = _address1;
@synthesize address2 = _address2;
@synthesize locationManger = _locationManger;
@synthesize addressPoint = _addressPoint;
@synthesize mPlacemark = _mPlacemark;
@synthesize resultPosition = _resultPosition;
@synthesize arrayLatitude = _arrayLatitude;
@synthesize arrayLongitude = _arrayLongitude;
@synthesize radioButtonArray = _radioButtonArray;
@synthesize toolbar;
@synthesize table;
@synthesize coordinate;
@synthesize mapView;

static NSString *goole_api_key = @"0bpdlAngqAMTbn5AV99pYjooL2-Ir276KNBtKHA";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    SetColor *color = [[SetColor alloc] init];
    [self.view setBackgroundColor:[color getColor:250 gColor:231 bColor:214]];
    
}

- (void)viewDidUnload
{
    [self setToolbarTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setAddressObjects:nil];
    [self setAddress1:nil];
    [self setAddress2:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)viewWillAppear:(BOOL)animated
{
    
    self.addr = [[addressItem alloc] init];
    self.address1 = [[NSString alloc] init];
    self.address2 = [[NSString alloc] init];
    self.arrayLatitude = [[NSMutableArray alloc] init];
    self.arrayLongitude = [[NSMutableArray alloc] init];
    self.radioButtonArray = [[NSMutableArray alloc] init];
    
    NSString *title = [[NSString alloc] initWithFormat:@"%d건 검색",[self.addressObjects count]];
    toolbarTitle.title = title;
    
    for (int i=0; i<[self.addressObjects count]; i++) {
        UIButton *radioButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [radioButton setImage:[UIImage imageNamed:@"radio-off.png"] forState:UIControlStateNormal];
        [radioButton setImage:[UIImage imageNamed:@"radio-on.png"] forState:UIControlStateSelected];
        [radioButton setFrame:CGRectMake(0, 0, 22, 22)];
        [radioButton addTarget:self action:@selector(radioButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.radioButtonArray addObject:radioButton];
    }
    
    [table reloadData];
    [self setPosition];
    
}


#pragma mark - User definition functions
-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:saveFile];
}

- (IBAction)closeView:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)sendSMS:(id)sender
{
    NSString *newAddress = [[NSString alloc] initWithFormat:[self getSelectAddr]];
    
    if (newAddress.length==0) {
        return;
    }
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if ([MFMessageComposeViewController canSendText]) {
        
        NSString *adr = [[NSString alloc] initWithFormat:@"도로명주소\n%@",newAddress];
        controller.body = adr;
        //cont.recipients = [NSArray arrayWithObjects:@"010-4296-2222", nil];
        controller.messageComposeDelegate = self;
        [self presentModalViewController:controller animated:YES];
    }else {
        NSLog(@"error");
    }
    
    
    
    
}

- (IBAction)copyAddress:(id)sender {

    NSString *newAddress = [[NSString alloc] initWithFormat:[self getSelectAddr]];
    
    if (newAddress.length==0) {
        return;
    }
    
    UIPasteboard *paste = [UIPasteboard generalPasteboard];
    paste.string = newAddress;
    

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"도로명주소를 복사하였습니다"
                                                   delegate:self
                                          cancelButtonTitle:@"확인"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)saveAddress:(UIButton *)sender{
    
    
    addressItem *item = [[addressItem alloc] init];
    item = [self.addressObjects objectAtIndex:sender.tag];
    
    
    NSString *oldAddress = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ %@",
                           item.sido,item.gugun,item.dong,item.lot_num,item.lot_sub_num,item.bldg_name];
    
    NSString *newAddress = [[NSString alloc] init];
    
    
    if ([item.bldg_sub_num intValue]>0) {
        newAddress = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ (%@)",item.sido,item.gugun,item.road_name,item.bldg_num,item.bldg_sub_num,item.dong_name];
    }else {
        newAddress = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@ (%@)",item.sido,item.gugun,item.road_name,item.bldg_num,item.dong_name];
    }
    

    
    NSString *filePath = [self dataFilePath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    [dict setValue:oldAddress forKey:@"oldAddress"];
    [dict setValue:newAddress forKey:@"newAddress"];
    
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



-(void)setPosition
{
    float rLatitude;
    float rLongitude;
    
    
    
    for (int i=0; i<[self.addressObjects count]; i++) {
        addressItem *atm = [[addressItem alloc] init];
        atm = [self.addressObjects objectAtIndex:i];
        
        rLatitude = [atm.latitude floatValue];
        rLongitude = [atm.longitude floatValue];
        NSNumber *temLatitude = [NSNumber numberWithFloat:rLatitude];
        NSNumber *temrLongitude = [NSNumber numberWithFloat:rLongitude];
        [self.arrayLatitude addObject:temLatitude];
        [self.arrayLongitude addObject:temrLongitude];
    }
    
    MKCoordinateRegion addrPosition;
    CLLocationCoordinate2D center;
    MKCoordinateSpan span;

    
    for (int i = 0; i < [self.arrayLatitude count] ; i++) {
        
        Annotation *ann = [[Annotation alloc] init];
        
        
        
        NSString *addr1 = [[NSString alloc] initWithFormat:@"%@ %@ %@",
                           [[self.addressObjects objectAtIndex:i] sido],
                           [[self.addressObjects objectAtIndex:i] gugun],
                           [[self.addressObjects objectAtIndex:i] dong]
                           ];
        NSString *addr2 = [[NSString alloc] initWithFormat:@"%@-%@ %@",
                           [[self.addressObjects objectAtIndex:i] lot_num],
                           [[self.addressObjects objectAtIndex:i] lot_sub_num],
                           [[self.addressObjects objectAtIndex:i] bldg_name]
                           ];

        /*
        NSString *addr2 = [[NSString alloc] init];
        if ([[[self.addressObjects objectAtIndex:i] bldg_sub_num] intValue]>0) {
            addr2 = [[NSString alloc] initWithFormat:@"%@-%@ %@",
                     [[self.addressObjects objectAtIndex:i] lot_num],
                     [[self.addressObjects objectAtIndex:i] lot_sub_num],
                     [[self.addressObjects objectAtIndex:i] bldg_name]
                     ];
        }else {
            addr2 = [[NSString alloc] initWithFormat:@"%@ (%@)",
                     [[self.addressObjects objectAtIndex:i] bldg_num],
                     [[self.addressObjects objectAtIndex:i] dong_name]
                     ];
        }
         */
        
        
        
        
        ann.title = [NSString stringWithFormat:@"%@", addr1];
        ann.subtitle = addr2;
        center.latitude = [[self.arrayLatitude objectAtIndex:i] doubleValue];
        center.longitude = [[self.arrayLongitude objectAtIndex:i] doubleValue];
        ann.coordinate = center;
        
        span.latitudeDelta = 0.02;
        span.longitudeDelta = 0.02;
        
        addrPosition.center = center;
        addrPosition.span = span;
        
        if (i==0) {
            [mapView setRegion:addrPosition animated:NO];
        }
        [mapView addAnnotation:ann];
    }
    

    
}

-(NSString *)getSelectAddr
{
    BOOL flag = FALSE;
    int row;
    for (UIButton *btn in self.radioButtonArray) {
        if (btn.selected) {
            flag = TRUE;
            row = btn.tag;
        }
    }
    
    if (!flag) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"선택하세요"
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return @"";
    }
    
    
    self.addr = [self.addressObjects objectAtIndex:row];
    
    
    NSString *newAddress = [[NSString alloc] init];
    
    if ([self.addr.bldg_sub_num intValue]>0) {
        newAddress = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ (%@)",self.addr.sido,self.addr.gugun,self.addr.road_name,self.addr.bldg_num,self.addr.bldg_sub_num,self.addr.dong_name];
    }else{
        newAddress = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@ (%@)",self.addr.sido,self.addr.gugun,self.addr.road_name,self.addr.bldg_num,self.addr.dong_name];
    }
    
    
    
    return newAddress;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.addressObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    */
    // Configure the cell...
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    self.addr = [self.addressObjects objectAtIndex:indexPath.row];    
    
    
    
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        
        for (id oneObject in nib) {
            if ([oneObject isKindOfClass:[CustomCell class]]) {
                cell = (CustomCell *)oneObject;
            }
        }
    }
    
    NSString *taddress1 = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ %@",
                           self.addr.sido,self.addr.gugun,self.addr.dong,self.addr.lot_num,self.addr.lot_sub_num,self.addr.bldg_name];
    
    NSString *taddress2 = [[NSString alloc] init];
    
    if ([self.addr.bldg_sub_num intValue]>0) {
        taddress2 = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ (%@)",self.addr.sido,self.addr.gugun,self.addr.road_name,self.addr.bldg_num,self.addr.bldg_sub_num,self.addr.dong_name];
    }else {
        taddress2 = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@ (%@)",self.addr.sido,self.addr.gugun,self.addr.road_name,self.addr.bldg_num,self.addr.dong_name];
    }
    
    
    NSString *zipcode = [[NSString alloc] initWithFormat:@"[%@]",self.addr.zipcode];
    cell.zipcode.text = zipcode;
    cell.oAddress.text = taddress1;
    cell.nAddress.text = taddress2;
    
    cell.item = self.addr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIButton *btn = [[UIButton alloc] init];
    btn = [self.radioButtonArray objectAtIndex:indexPath.row];
    btn.tag = indexPath.row;
    
    [cell.radioView addSubview:btn];
    return cell;
}


-(IBAction)radioButtonPressed:(UIButton *)button
{
    [button setSelected:YES];
    for (UIButton *other in self.radioButtonArray) {
        if (other!=button) {
            other.selected = NO;
        }
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"%d",indexPath.row);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

#pragma mark - SMS delegate

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
