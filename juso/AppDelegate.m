//
//  AppDelegate.m
//  juso
//
//  Created by jungho jang on 12. 1. 13..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "CompanyInfoViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize viewController1;
@synthesize viewController2;
@synthesize viewController3;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    viewController3 = [[CompanyInfoViewController alloc] initWithNibName:@"CompanyInfoViewController" bundle:nil];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, viewController3, nil];
    //self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    
    [self AddCaulyAD];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/


#pragma mark - Cauly

// 전면 광고 뷰 추가
- (void)AddCaulyAD {
	
	
    // 카울리 초기화. 카울리 광고를 붙이기 전에(requestXXX를 호출하기 전에) 반드시 초기화를 먼저 시켜주시기 바랍니다.
    // [CaulyViewController initCauly:self];						// 카울리 콘솔 로그 레벨 설정이 필요없을 경우 사용. 이와같이 호출하면 카울리 관련 로그는 남지 않습니다.
	[CaulyViewController initCauly:self setLogLevel:CL_RELEASE];	// 카울리 로그를 남기도록 설정
    
    
    /////////////////////////////////////////////////////////////////
    // 카울리 전면광고 요청 로직
    // 전면 광고 요청 후 바로 배너광고를 요청하게 되면 전면광고가 배너광고를 가리게 되서 배너광고가 안보이게 됩니다.
    // 따라서 전면광고 요청시에는 전면광고 뷰가 닫힐때 호출되는 closeCPMAd 메소드에서 전면광고 종료 후 처리를 해 주시면 됩니다.
    // 만약 전면광고를 안쓰는 앱의 경우는 전면 광고 요청 부분을 삭제하시고 밑에 주석부분에 있는 배너광고 요청을 바로 해 주시면 됩니다.
    /////////////////////////////////////////////////////////////////
	/*
    NSLog(@"전면광고 노출");
    
	if( [CaulyViewController requestFullAD] == FALSE ) {
		NSLog(@"requestFullAD failed");
	}
    */
    /////////////////////////////////////////////////////////////////
    
    
    /////////////////////////////////////////////////////////////////
    // 카울리 배너광고 요청
    // 만약 전면광고 노출을 생략하고 싶으면 위의 전면광고 요청 부분을 생략하고 아래 배너광고를 바로 요청하면 됩니다.
    // 단, 이 경우 closeCPMAd callback메소드는 호출되지 않으므로 closeCPMAd메소드에 구현한 내용을 아래에서 구현해 주어야 합니다.
    //
    //NSLog(@"배너광고 노출");
    if( [CaulyViewController requestBannerADWithViewController:viewController1 xPos:0 yPos:363 adType:BT_IPHONE] == FALSE ) {
        NSLog(@"requestBannerAD failed1");
    }
    
    /////////////////////////////////////////////////////////////////
}

#pragma mark - CaulyProtocol method

/////////////////////////////////////////////////////////////////////////////////////////////////////////
// 주! 아래 카울리 프로토콜 구현 메소드의 리턴값에 특수문자나 공백이 들어가 있으면 광고정보를 정상적으로 못 얻어 옵니다.    //
////////////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString *) devKey 
{
	//return @"CAULY"; //CAULY는 테스트용 개발코드입니다. 제품 배포시에는 발급받은 어플리케이션 고유개발코드로 변환해 주세요.
    return @"QJlwSmX1";
}

// 성별 값을 리턴합니다. "male", "female", "all"
- (NSString *) gender
{
	return @"all";	// 공백이나 특수문자는 사용할 수 없습니다.
}

// 나이 값을 리턴합니다. "all", "10", "20", "30", "40", "50"
- (NSString *) age
{
	return @"all";	// 공백이나 특수문자는 사용할 수 없습니다.
}

// 카울리 시스템이 위치 정보를 수집하도록 설정합니다.
// 카울리 시스템이 위치 정보를 수집할 경우 사용자에 맞는 광고를 내 보내주게 되고 이를 통해 광고 수입이 늘어 날 수 있게 됩니다.
- (BOOL) getGPSInfo
{
    //	return TRUE; // 리턴값을 TRUE로 하게되면 사용자들로 하여금 위치 정보 승인을 물어보게 됩니다.
	return FALSE;
}

// 광고 교체 주기값을 설정합니다.
- (REFRESH_PERIOD) rollingPeriod {
	return SEC_30;
}

// 광고가 바뀔 때의 효과를 설정합니다.
- (ANIMATION_TYPE) animationType {
	return FADEOUT;
}

// 광고 데이터를 받고 나면 호출됩니다.
- (void)AdReceiveCompleted {
	//NSLog(@"AdReceiveCompleted..");
}

// 광고 데이터를 받는데 실패하면 호출됩니다.
- (void)AdReceiveFailed {
	//NSLog(@"AdReceiveFailed..");
}

// 전면 광고를 종료시키면 호출됩니다.
// 만약 전면 광고를 요청하지 않을 경우 이 메소드는 호출되지 않습니다.
// 전면 광고와 배너 광고를 동시에 노출 시킬 수 없으므로 전면 광고가 종료된 뒤 배너 광고를 노출시키기 바랍니다.
- (void)closeCPMAd {
	//NSLog(@"배너광고 노출");
	
	// 이 예제의 경우 requestBannerADWithViewController 메소드를 이용하였습니다.
	// 만약 viewController를 사용하지 않는 앱의 경우 아래와 같이 requestBannerADWithView메소드를 이용하시기 바랍니다.
	// 예) [CaulyViewController requestBannerADWithView:parentView xPos:0 yPos:0]
	
    //	if( [CaulyViewController requestBannerADWithView:viewController.view xPos:0 yPos:0 adType:BT_IPHONE] == FALSE ) {
	if( [CaulyViewController requestBannerADWithViewController:viewController1 xPos:0 yPos:0 adType:BT_IPHONE] == FALSE ) {
		NSLog(@"requestBannerAD failed");
	}
}

- (BOOL) dynamicReloadInterval
{
    return TRUE;
}



@end
