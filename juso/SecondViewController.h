//
//  SecondViewController.h
//  juso
//
//  Created by jungho jang on 12. 1. 13..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#define saveFile @"address"
@interface SecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSString *filePath;
    NSMutableArray *addressData;
    NSMutableDictionary *dict;
}
@property (strong, retain) NSString *filePath;
@property (strong, retain) NSMutableArray *addressData;
@property (strong, nonatomic) IBOutlet UITableView *addressListTable;
@property (strong, retain)  NSMutableDictionary *dict;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editBtn;

-(NSString *)dataFilePath;
- (IBAction)editTable:(id)sender;
@end
