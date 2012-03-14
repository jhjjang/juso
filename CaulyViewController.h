//
//  CaulyViewController.h
//  Cauly
//
//  Created by FutureStream Networks co.
//  Copyright 2010 FutureStream Networks co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CaulyProtocol.h"

@protocol CaulyProtocol;

@interface CaulyViewController : UIViewController {

}

// 카울리 초기화 및 로그레벨 설정
// 초기화 : 카울리가 사용할 delegate함수를 설정합니다.
//        !! 광고 요청을 하기전 가장 먼저 초기화 메소드를 호출하여 주셔야 합니다.
// 로그레벨 설정 : CaulyProtocol.h 에 정의되어 있는 CL_NOLOG, CL_RELEASE, CL_DEBUG, CL_ALL 중 하나를 설정해 주시면 됩니다.
//				왼쪽값에서 오른쪽값으로 갈수록 로그가 많이 남습니다. 로그 레벨을 설정 안하면 기본값은 CL_NOLOG로 설정됩니다.
//				앱을 release할때는 CL_NOLOG/CL_RELEASE를 사용하시고 개발 도중에 로그를 확인하고 싶으실 때는 다른 로그 레벨을 사용해 주세요.
+ (void) initCauly:(id<CaulyProtocol>)delegate;
+ (void) initCauly:(id<CaulyProtocol>)delegate setLogLevel:(CAULYLOGTYPE)caulyLogLevel;

// 전면광고 노출 요청
// 전면광고는 제약없이 언제든 호출할 수 있습니다.
// 아이패드는 전면광고를 지원하지 않습니다.
+ (BOOL) requestFullAD;

// 배너광고 노출 요청
// view를 사용하는 어플 일경우 사용.
+ (BOOL) requestBannerADWithView:(UIView*)parentView
							xPos:(float)x
							yPos:(float)y
						  adType:(BANNERAD_TYPE)adType;

// 배너광고 노출 요청
// viewController 객체를 사용하는 어플 일경우 사용.
// 카울리 뷰는 viewController의 뷰에 붙게 됩니다.
+ (BOOL) requestBannerADWithViewController:(UIViewController*)parentController
									  xPos:(float)x
									  yPos:(float)y
									adType:(BANNERAD_TYPE)adType;

// 배너광고 노출 요청
// viewController를 사용하는 어플 일경우 parentController인자에 해당 viewController를 넘겨 주시고,
// view만을 사용하는 어플 일경우에는 parentView인자에 해당 view를 넘겨 주세요.
// viewController객체를 넘겨주게 되면 view객체는 자동으로 viewController의 view를 이용하게 됩니다.
// 둘다 nil일 경우에는 메소드 호출이 실패합니다.
// 2.0.5 이전 사용 메소드. 아이폰 용 배너 광고만 사용가능. 2.1.0 이후로는 사용하지 마시기 바랍니다.
// 가능한 requestBannerADWithView나 requestBannerADWithController 메소드를 이용하시기 바랍니다.
+ (BOOL) requestBannerAD:(UIViewController*)parentController		// 광고를 붙일 뷰컨트롤러
		 caulyParentview:(UIView*)parentView						// 광고를 붙일 뷰
					xPos:(float)x								// 광고의 x좌표
					yPos:(float)y;								// 광고의 y좌표

// 배너광고 이동
// 위치를 이동시키거나 새로운 뷰/뷰컨트롤러 에 붙이려고 할때 호출합니다.
// 기존 뷰에서는 자동으로 remove됩니다.
+ (BOOL) moveBannerAD:(UIViewController*)parentController		// 광고를 붙일 뷰컨트롤러
	  caulyParentview:(UIView*)parentView						// 광고를 붙일 뷰
				 xPos:(float)x									// 광고의 x좌표
				 yPos:(float)y;									// 광고의 y좌표

// 배너광고의 노출상태(카울리뷰의 hidden상태값) 셋팅 함수
// setState 값이 YES이면 View가 감춰집니다. 다시 나타나게 하려면 setState값을 NO로 호출하시면 됩니다.
+ (BOOL) hideBannerAD:(BOOL)setState;

// 카울리 뷰를 현재 붙어 있는 부모뷰의 가장 앞단으로 불러오는 메소드
+ (BOOL) bringCaulyBannerADToFront;

// 카울리 뷰의 현재 위치 값을 리턴하는 메소드
+ (CGPoint) getCaulyViewPosition;



@end
