//
//  FirstViewController.m
//  juso
//
//  Created by jungho jang on 12. 1. 13..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "FirstViewController.h"
#import "TBXML.h"
#import "SetColor.h"
#import "addressItem.h"
#import "ResultViewController.h"
#import "MultiResultViewController.h"
@implementation FirstViewController
@synthesize receiveData = _receiveData;
@synthesize addressObject = _addressObject;
@synthesize connection = _connection;
@synthesize dongNameTextField = _dongNameTextField;
@synthesize bunji1TextField = _bunji1TextField;
@synthesize bunji2TextField = _bunji2TextField;
@synthesize sanSwitch = _sanSwitch;
@synthesize buildingNameTextField = _buildingNameTextField;
@synthesize sidoTextField = _sidoTextField;
@synthesize gugunTextField = _gugunTextField;
@synthesize mode = _mode;
@synthesize actionSheet = _actionSheet;
@synthesize pickerView = _pickerView;
@synthesize addressDict = _addressDict;
@synthesize gugunDict = _gugunDict;
@synthesize sidoArray = _sidoArray;
@synthesize gugunArray = _gugunArray;
@synthesize dongArray = _dongArray;
@synthesize scrollView = _scrollView;
@synthesize buildingLable = _buildingLable;
@synthesize sanLabel = _sanLabel;
@synthesize dashLabel = _dashLabel;
@synthesize getResultBtn = _getResultBtn;
@synthesize bunjiLabel = _bunjiLabel;
@synthesize resultViewControler = _resultViewControler;
@synthesize multiResultController = _multiResultController;
@synthesize segmentControl = _segmentControl;


-(void)hideKeyboard
{
    /*
    // 키보드숨기기 확인버튼
    //SetColor *color = [[SetColor alloc] init];
	UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 30.0)];
	//inputAccessoryView.backgroundColor = [color getColor:125 gColor:125 bColor:0];
    inputAccessoryView.backgroundColor = [UIColor lightGrayColor];
    //inputAccessoryView.alpha = 0.1;
    [inputAccessoryView setAlpha:0.01f];
    
    UIButton *confrimBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confrimBtn.frame = CGRectMake(260, 3.0, 50, 25);
    confrimBtn.backgroundColor = [UIColor clearColor];
    //[confrimBtn setTitle:@"Close" forState:UIControlStateNormal];
    [confrimBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [confrimBtn setBackgroundImage:[UIImage imageNamed:@"btn_submit.png"] forState:UIControlStateNormal];
    
    
    //[confrimBtn setTitle:@"확인" forState:UIControlStateNormal];
    
	[confrimBtn addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
	[inputAccessoryView addSubview:confrimBtn];
    */
    UIToolbar *inputAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 20.0)];
    inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
    inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [inputAccessoryView sizeToFit];
    CGRect frame = inputAccessoryView.frame;
    frame.size.height = 44.0f;
    inputAccessoryView.frame = frame;
    
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                             target:self
                                                                             action:@selector(confirm:)];

    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
    NSArray *array = [NSArray arrayWithObjects:flexibleSpace,doneBtn, nil];
    [inputAccessoryView setItems:array];
    
    
    
    self.dongNameTextField.inputAccessoryView = inputAccessoryView;
    self.bunji1TextField.inputAccessoryView = inputAccessoryView;
    self.bunji2TextField.inputAccessoryView = inputAccessoryView;
    self.buildingNameTextField.inputAccessoryView = inputAccessoryView;
}


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"주소변환";
        self.tabBarItem.image = [UIImage imageNamed:@"navi01"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.buildingNameTextField.hidden = YES;
    self.buildingLable.hidden = YES;
    
    [self hideKeyboard];

}

-(void)confirm:(id)sender
{
    [self.dongNameTextField resignFirstResponder];
    [self.bunji1TextField resignFirstResponder];
    [self.bunji2TextField resignFirstResponder];
    [self.buildingNameTextField resignFirstResponder];
}


- (void)viewDidUnload
{    
    [self setDongNameTextField:nil];
    [self setBunji1TextField:nil];
    [self setBunji2TextField:nil];
    [self setSanSwitch:nil];
    [self setBuildingNameTextField:nil];
    [self setSidoTextField:nil];
    [self setAddressDict:nil];
    [self setGugunDict:nil];
    [self setSidoArray:nil];
    [self setGugunArray:nil];
    [self setDongArray:nil];
    [self setPickerView:nil];
    [self setActionSheet:nil];
    [self setBunjiLabel:nil];
    [self setBuildingLable:nil];
    [self setScrollView:nil];
    [self setSanLabel:nil];
    [self setDashLabel:nil];
    [self setGugunTextField:nil];
    [self setGetResultBtn:nil];
    [self setSegmentControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification
                                               object:nil];
    
    keyboardVisible = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)selectMode:(id)sender {    
    self.mode = [sender selectedSegmentIndex];
    switch ([sender selectedSegmentIndex]) {
        case 0:
            self.buildingNameTextField.hidden = YES;
            self.buildingLable.hidden = YES;
            self.bunji1TextField.hidden = NO;
            self.bunji2TextField.hidden = NO;
            self.bunjiLabel.hidden = NO;
            self.dashLabel.hidden = NO;
            self.sanSwitch.hidden = NO;
            self.sanLabel.hidden = NO;
            break;
        case 1:
            self.buildingNameTextField.hidden = NO;
            self.buildingLable.hidden = NO;
            self.bunji1TextField.hidden = YES;
            self.bunji2TextField.hidden = YES;
            self.bunjiLabel.hidden = YES;
            self.dashLabel.hidden = YES;
            self.sanSwitch.hidden = YES;
            self.sanLabel.hidden = YES;
            
            break;
        default:
            break;
    }
}

- (IBAction)getResult:(id)sender {
    
    [self confirm:nil];
    if (self.sidoTextField.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"시도를 선택하세요"
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    NSString *url = [[NSString alloc] init];
    
    
    if (self.dongNameTextField.text.length==0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"동명을 입력하세요"
                                                       delegate:self
                                              cancelButtonTitle:@"확인"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(self.mode==0)
    {
        
        
        if (self.bunji1TextField.text.length==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"번지를 입력하세요"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        if (self.bunji2TextField.text.length==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"번지를 입력하세요"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }

        url = [[NSString stringWithFormat:@"http://address.incn.co.kr/index.php?sido=%@&gugun=%@&dongName=%@&bunji1=%@&bunji2=%@&issan=%d",
                          self.sidoTextField.text,
                          self.gugunTextField.text,
                          self.dongNameTextField.text,
                          self.bunji1TextField.text,
                          self.bunji2TextField.text,
                          self.sanSwitch.isOn] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    }else{
        if (self.buildingNameTextField.text.length==0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"건물명을 입력하세요"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles:nil];
            [alert show];
            return;
        }  
        
        url = [[NSString stringWithFormat:@"http://address.incn.co.kr/index.php?sido=%@&gugun=%@&dongName=%@&buildingName=%@",
                self.sidoTextField.text,
                self.gugunTextField.text,
                self.dongNameTextField.text,
                self.buildingNameTextField.text,
                self.sanSwitch.isOn] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
    
    if (self.connection) {
        self.receiveData = [[NSMutableData alloc] init];
    }
    
    
    [self.getResultBtn setEnabled:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    
}

- (IBAction)selectSido:(id)sender {
    [sender resignFirstResponder];
    
    [self confirm:nil];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                      delegate:nil
                                             cancelButtonTitle:nil
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil];
    
    self.actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 216)];
    
    /*
    //시/도 구/군선택
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"address" ofType:@"plist"];
    
    addressDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    self.sidoArray = [addressDict allKeys];
    
    NSArray *sorted = [self.sidoArray sortedArrayUsingSelector:@selector(compare:)];
    self.sidoArray = sorted;
    
    NSString *selectedGugun = [self.sidoArray objectAtIndex:7];
    NSArray *array = [addressDict objectForKey:selectedGugun];
    self.gugunArray = array;
    
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    [self.pickerView selectRow:7 inComponent:0 animated:NO];
    [self.actionSheet addSubview:self.pickerView];
    //시/도 구/군선택 End 
    */
    
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *filePath = [bundle pathForResource:@"dong" ofType:@"plist"];
    
    addressDict = [[NSDictionary alloc] initWithContentsOfFile:filePath];
    self.sidoArray = [addressDict allKeys];
    
    NSArray *sorted = [self.sidoArray sortedArrayUsingSelector:@selector(compare:)];
    self.sidoArray = sorted;
    
    NSString *selectedGugun = [self.sidoArray objectAtIndex:7];
    NSArray *array = [addressDict objectForKey:selectedGugun];

    
    gugunDict = [[NSDictionary alloc] initWithDictionary:[array objectAtIndex:0]];
    
    NSArray *local_array = [gugunDict allKeys];
    NSArray *tsorted = [local_array sortedArrayUsingSelector:@selector(compare:)];
    NSArray *tarray = tsorted;
    self.gugunArray = tarray;
    
    NSString *selectDong = [self.gugunArray objectAtIndex:0];
    NSArray *sarray = [gugunDict objectForKey:selectDong];
    self.dongArray = sarray;

    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    [self.pickerView selectRow:7 inComponent:0 animated:NO];
    [self.actionSheet addSubview:self.pickerView];
    
    
    
    UIToolbar *pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolBar.barStyle = UIBarStyleBlackTranslucent;
    [pickerToolBar setTintColor:[UIColor blackColor]];
    [pickerToolBar sizeToFit];
    
    UIBarButtonItem *flexSpaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:self
                                                                                   action:nil];
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                   target:self
                                                                                   action:@selector(cancelActionSheet)];
    UIBarButtonItem *doneBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                 target:self
                                                                                 action:@selector(doneActionSheet)];

    [pickerToolBar setItems:[NSArray arrayWithObjects:flexSpaceItem,cancelBtnItem,doneBtnItem, nil]];
    [self.actionSheet addSubview:pickerToolBar];
    
    [self.actionSheet showFromTabBar:self.tabBarController.tabBar];
    [self.actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
     
}



-(void)cancelActionSheet
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)doneActionSheet
{    
    self.sidoTextField.text = [self.sidoArray objectAtIndex:[self.pickerView selectedRowInComponent:kSidoComponent]];
    self.gugunTextField.text = [self.gugunArray objectAtIndex:[self.pickerView selectedRowInComponent:kGugunComponent]];
    self.dongNameTextField.text = [self.dongArray objectAtIndex:[self.pickerView selectedRowInComponent:kDongComponent]];
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma mark - HTTPRequest

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[self.receiveData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.resultViewControler = [[ResultViewController alloc] init];
    self.multiResultController = [[MultiResultViewController alloc] init];
    
    [self.getResultBtn setEnabled:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	self.addressObject = [[NSMutableArray alloc] init];
    
	//NSString *str = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
    //NSLog(@"%s",[self.receiveData bytes]);
    
    TBXML *tbxml = [[TBXML alloc] initWithXMLData:self.receiveData];
    TBXMLElement *root = tbxml.rootXMLElement;

    if(root !=nil)
    {
        
        TBXMLElement *newEntry = [TBXML childElementNamed:@"item" parentElement:root];
        while(newEntry != nil)
        {
            TBXMLElement *zipcode = [TBXML childElementNamed:@"zipcode" parentElement:newEntry];
            TBXMLElement *sido = [TBXML childElementNamed:@"sido" parentElement:newEntry];
            TBXMLElement *gugun = [TBXML childElementNamed:@"gugun" parentElement:newEntry];
            TBXMLElement *dong = [TBXML childElementNamed:@"dong" parentElement:newEntry];
            TBXMLElement *lot_num = [TBXML childElementNamed:@"lot_num" parentElement:newEntry];
            TBXMLElement *lot_sub_num = [TBXML childElementNamed:@"lot_sub_num" parentElement:newEntry];
            TBXMLElement *road_name = [TBXML childElementNamed:@"road_name" parentElement:newEntry];
            TBXMLElement *bldg_num = [TBXML childElementNamed:@"bldg_num" parentElement:newEntry];
            TBXMLElement *bldg_sub_num = [TBXML childElementNamed:@"bldg_sub_num" parentElement:newEntry];
            TBXMLElement *dong_name = [TBXML childElementNamed:@"dong_name" parentElement:newEntry];
            TBXMLElement *bldg_name = [TBXML childElementNamed:@"bldg_name" parentElement:newEntry];
            TBXMLElement *longitude = [TBXML childElementNamed:@"longitude" parentElement:newEntry];
            TBXMLElement *latitude = [TBXML childElementNamed:@"latitude" parentElement:newEntry];
            
            
            addressItem *addr = [[addressItem alloc] init];
            addr.zipcode = [TBXML textForElement:zipcode];
            addr.sido = [TBXML textForElement:sido];
            addr.gugun = [TBXML textForElement:gugun];
            addr.dong = [TBXML textForElement:dong];
            addr.lot_num = [TBXML textForElement:lot_num];
            addr.lot_sub_num = [TBXML textForElement:lot_sub_num];
            addr.road_name = [TBXML textForElement:road_name];
            addr.bldg_num = [TBXML textForElement:bldg_num];
            addr.bldg_sub_num = [TBXML textForElement:bldg_sub_num];
            addr.dong_name = [TBXML textForElement:dong_name];
            addr.bldg_name = [TBXML textForElement:bldg_name];
            addr.longitude = [TBXML textForElement:longitude];
            addr.latitude = [TBXML textForElement:latitude];

            [self.addressObject addObject:addr];
            newEntry = [TBXML nextSiblingNamed:@"item" searchFromElement:newEntry];
        }
        
        if([self.addressObject count] > 0){
            if ([self.addressObject count]<2) {
                addressItem *result = [[addressItem alloc] init];
                result = [self.addressObject objectAtIndex:0];
                self.resultViewControler.item = result;
            }else {
                self.multiResultController.addressObjects = self.addressObject;
            }
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                            message:@"일치하는 주소가 없습니다"
                                                           delegate:self
                                                  cancelButtonTitle:@"확인"
                                                  otherButtonTitles: nil];
            [alert show];
            
            return;
        }
        
    }
	  
    
    if ([self.addressObject count]<2) {
        [self presentModalViewController:self.resultViewControler animated:YES];
    }else {
        [self presentModalViewController:self.multiResultController animated:YES];
    }
    
    
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

#pragma mark - PickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==kSidoComponent) {
        return [self.sidoArray count];
    }else if(component==kGugunComponent){
        return [self.gugunArray count];
    }else{
        return [self.dongArray count];
    }
    
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==kSidoComponent) {
        return [self.sidoArray objectAtIndex:row];
    }else if(component==kGugunComponent){
        return [self.gugunArray objectAtIndex:row];
    }else{
        return [self.dongArray objectAtIndex:row];
    }
}

-(void)pickerView:(UIPickerView *)tpickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component==kSidoComponent) {
        /*
        NSString *selectedGugun = [self.sidoArray objectAtIndex:row];
        NSArray *array = [addressDict objectForKey:selectedGugun];
        self.gugunArray = array;
        [self.pickerView selectRow:0 inComponent:kGugunComponent animated:YES];
        [self.pickerView reloadComponent:kGugunComponent];
         */
        NSString *selectedGugun = [self.sidoArray objectAtIndex:row];
        NSArray *array = [addressDict objectForKey:selectedGugun];
        
        
        gugunDict = [[NSDictionary alloc] initWithDictionary:[array objectAtIndex:0]];
        
        NSArray *local_array = [gugunDict allKeys];
        NSArray *tsorted = [local_array sortedArrayUsingSelector:@selector(compare:)];
        NSArray *tarray = tsorted;
        self.gugunArray = tarray;
        
        NSString *selectDong = [self.gugunArray objectAtIndex:0];
        NSArray *sarray = [gugunDict objectForKey:selectDong];
        self.dongArray = sarray;
        
        [self.pickerView selectRow:0 inComponent:kGugunComponent animated:YES];
        [self.pickerView selectRow:0 inComponent:kDongComponent animated:YES];
        [self.pickerView reloadComponent:kGugunComponent];
        [self.pickerView reloadComponent:kDongComponent];
    }else if(component==kGugunComponent){
        
        NSString *selectDong = [self.gugunArray objectAtIndex:row];
        NSArray *sarray = [gugunDict objectForKey:selectDong];
        self.dongArray = sarray;
        [self.pickerView selectRow:0 inComponent:kDongComponent animated:YES];
        [self.pickerView reloadComponent:kDongComponent];
    }
}

-(CGFloat)pickerView:(UIPickerView *)tpickerView widthForComponent:(NSInteger)component
{
    if (component==kSidoComponent) {
        return 60;
    }else if(component==kGugunComponent){
        return 140;
    }else if(component==kDongComponent){
        return 90;
    }else{
        return 0;
    }
        
}


-(UIView*)pickerView:(UIPickerView *)tpickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *retval = (id)view;
    if(!retval){
        retval = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [tpickerView rowSizeForComponent:component].width, [tpickerView rowSizeForComponent:component].height)];
    }
    [retval setBackgroundColor:[UIColor clearColor]];
    
    NSString *title = [[NSString alloc] init];
    if (component==kSidoComponent) {
        title = [self.sidoArray objectAtIndex:row];
    }else if(component==kGugunComponent){
        title = [self.gugunArray objectAtIndex:row];
    }else{
        title = [self.dongArray objectAtIndex:row];
    }

    retval.text = title;
    retval.font = [UIFont systemFontOfSize:15];
    retval.textAlignment = UITextAlignmentCenter;
    
    return retval;
}

#pragma mark - Keyboard Show/Hide
-(void)keyboardDidShow:(NSNotification *)notif
{
    if (keyboardVisible) {
        return;
    }
    
    
    NSDictionary *info = [notif userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    viewFrame.size.height -= keyboardSize.height-120;
    self.scrollView.frame = viewFrame;

    keyboardVisible = YES;
}

-(void)keyboardDidHide:(NSNotification *)notif
{
    if (!keyboardVisible) {
        return;
    }
    NSDictionary *info = [notif userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.scrollView.frame;
    
    viewFrame.size.height += keyboardSize.height+120;

    self.scrollView.frame = viewFrame;
    keyboardVisible = NO;
}




#pragma mark - textFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //NSLog(@"%f",textField.frame.origin.y);
    //[self.scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y) animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    //[self.scrollView setContentOffset:CGPointMake(0, textField.frame.origin.y) animated:YES];
}



#pragma mark - 


@end
