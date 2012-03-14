//
//  addressItem.h
//  juso
//
//  Created by jungho jang on 12. 1. 16..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addressItem : NSObject
{
    NSString *zipcode;
    NSString *sido;
    NSString *gugun;
    NSString *dong;
    NSString *lot_num;
    NSString *lot_sub_num;
    NSString *road_name;
    NSString *bldg_num;
    NSString *bldg_sub_num;
    NSString *dong_name;
    NSString *bldg_name;
    NSString *longitude;
    NSString *latitude;
}

@property (strong, nonatomic) NSString *zipcode;
@property (strong, nonatomic) NSString *sido;
@property (strong, nonatomic) NSString *gugun;
@property (strong, nonatomic) NSString *dong;
@property (strong, nonatomic) NSString *lot_num;
@property (strong, nonatomic) NSString *lot_sub_num;
@property (strong, nonatomic) NSString *road_name;
@property (strong, nonatomic) NSString *bldg_num;
@property (strong, nonatomic) NSString *bldg_sub_num;
@property (strong, nonatomic) NSString *dong_name;
@property (strong, nonatomic) NSString *bldg_name;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *latitude;
@end
