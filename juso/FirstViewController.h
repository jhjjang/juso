//
//  FirstViewController.h
//  juso
//
//  Created by jungho jang on 12. 1. 13..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPRequest.h"

#define kSidoComponent  0
#define kGugunComponent 1
#define kDongComponent  2
@class ResultViewController;
@class MultiResultViewController;
@interface FirstViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIActionSheetDelegate,UIScrollViewDelegate>
{
    NSDictionary *addressDict;
    NSDictionary *gugunDict;
    NSMutableData *receiveData;
    NSMutableArray *addressObject;
    NSURLConnection *connection;
    NSUInteger mode;
    UIPickerView *pickerView;
    NSArray *sidoArray;
    NSArray *gugunArray;
    NSArray *dongArray;
    UILabel *bunjiLabel;
    UILabel *buildingLable;

    
    UIScrollView *scrollView;
    BOOL keyboardVisible;
    
    ResultViewController *resultViewControler;
    MultiResultViewController *multiResultController;
}
@property (nonatomic, retain) NSMutableData *receiveData;
@property (nonatomic, retain) NSMutableArray *addressObject;
@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) ResultViewController *resultViewControler;
@property (nonatomic, retain) MultiResultViewController *multiResultController;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) IBOutlet UITextField *dongNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *bunji1TextField;
@property (strong, nonatomic) IBOutlet UITextField *bunji2TextField;

@property (strong, nonatomic) IBOutlet UISwitch *sanSwitch;
@property (strong, nonatomic) IBOutlet UITextField *buildingNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *sidoTextField;
@property (strong, nonatomic) IBOutlet UITextField *gugunTextField;
@property (assign) NSUInteger mode;

@property (strong, nonatomic) IBOutlet UILabel *bunjiLabel;
@property (strong, nonatomic) IBOutlet UILabel *buildingLable;
@property (strong, nonatomic) IBOutlet UILabel *sanLabel;
@property (strong, nonatomic) IBOutlet UILabel *dashLabel;
@property (strong, nonatomic) IBOutlet UIButton *getResultBtn;

@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSDictionary *addressDict;
@property (strong, nonatomic) NSDictionary *gugunDict;
@property (strong, nonatomic) NSArray *sidoArray;
@property (strong, nonatomic) NSArray *gugunArray;
@property (strong, nonatomic) NSArray *dongArray;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

-(void)hideKeyboard;
-(void)confirm:(id)sender;
-(void)keyboardDidShow:(NSNotification *)notif;
-(void)keyboardDidHide:(NSNotification *)notif;

- (IBAction)selectMode:(id)sender;
- (IBAction)getResult:(id)sender;
- (IBAction)selectSido:(id)sender;

@end
