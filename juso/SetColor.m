//
//  SetColor.m
//  frontiertimes
//
//  Created by jungho jang on 11. 12. 23..
//  Copyright (c) 2011년 INCN. All rights reserved.
//

#import "SetColor.h"

@implementation SetColor

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(UIColor *)getColor:(int)red gColor:(int)green bColor:(int)blue
{
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

@end
