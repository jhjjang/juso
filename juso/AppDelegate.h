//
//  AppDelegate.h
//  juso
//
//  Created by jungho jang on 12. 1. 13..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaulyViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,CaulyProtocol>
{
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController1;
@property (strong, nonatomic) UIViewController *viewController2;
@property (strong, nonatomic) UIViewController *viewController3;
@property (strong, nonatomic) UITabBarController *tabBarController;

-(void)AddCaulyAD;
@end
