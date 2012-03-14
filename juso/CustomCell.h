//
//  CustomCell.h
//  juso
//
//  Created by jungho jang on 12. 1. 25..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "addressItem.h"

#define saveFile @"address"
@interface CustomCell : UITableViewCell
{
    addressItem *item;
}
@property (strong, nonatomic) IBOutlet UILabel *zipcode;
@property (nonatomic, retain) IBOutlet UILabel *oAddress;
@property (nonatomic, retain) IBOutlet UILabel *nAddress;
@property (strong, nonatomic) IBOutlet UIView *radioView;

@property (nonatomic, retain) addressItem *item;


- (void)saveAddress:(id)sender;
+(id)cellWithNib;
@end
