//
//  CustomCell.m
//  juso
//
//  Created by jungho jang on 12. 1. 25..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize zipcode;

@synthesize oAddress, nAddress;
@synthesize radioView;
@synthesize item;


-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:saveFile];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        item = [[addressItem alloc] init];
        NSLog(@"init aaa");
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}




- (void)saveAddress:(id)sender {
    
    
    
    NSString *oldAddress = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ %@",
                            item.sido,item.gugun,item.dong,item.lot_num,item.lot_sub_num,item.bldg_name];
    /*
    NSString *newAddress = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@-%@ (%@)",item.sido,item.gugun,item.road_name,item.bldg_num,item.bldg_sub_num,item.dong_name];
    */
    
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



+(id)cellWithNib
{
    CustomCell *cell;
    UIViewController *controller = [[UIViewController alloc] initWithNibName:@"CustomCell" bundle:nil];
    cell = (CustomCell *)controller.view;
    
    return cell;
}



@end
