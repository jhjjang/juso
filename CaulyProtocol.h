//
//  CaulyProtocol.h
//  Cauly
//
//  Created by FutureStream Networks co.
//  Copyright 2010 FutureStream Networks co. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	BT_IPHONE = 0,	// 320x48
	BT_IPAD_LARGE,	// 728x90
	BT_IPAD_SMALL	// 468x60
} BANNERAD_TYPE;

typedef enum {
	SEC_30 = 0,
	SEC_60,
	SEC_120,
	NONE
} REFRESH_PERIOD;

typedef enum {
	CURLUP = 0,
	CURLDOWN,
	FLIPFROMLEFT,
	FLIPFROMRIGHT,
	FADEOUT,
	NOANIMATION
} ANIMATION_TYPE;

typedef enum {
	CL_NOLOG = 0,
	CL_RELEASE,
	CL_DEBUG,
	CL_ALL
} CAULYLOGTYPE;


@class CaulyView;

// Cauly Protocol 메소드
// 주!. 리턴값에 특수문자나 공백이 들어 있을 경우 광고 호출에 실패합니다.
@protocol CaulyProtocol<NSObject>

@required

// Cauly 홈페이지에서 발급받은 key값을 리턴합니다.
- (NSString *) devKey;

@optional

//--- 사용자 정보 수집 메소드
// 아래의 값들은 어플리케이션에서 해당 정보를 갖고 있을 경우 채워 주는 값입니다.
// 아래 값이 채워져 있으면 좀더 해당 어플 사용자에 적합한 광고를 보여 줄 수 있고, 그만큼 광고 수입이 늘어날 수 있습니다.
// 옆의 주석에 적혀있는 포맷에 맞게 전달해 주시기 바랍니다.
// 공백이나 특수문자 또는 한글은 사용할 수 없습니다.
- (NSString *) gender; // male, female, all
- (NSString *) age; // 10, 20, 30, 40, 50, all

// 위치 정보 수신 동의 메소드
// 기존에는 개발자가 gps메소드를 이용하여 위치 정보를 전달해 줘야 했으나, 2.1.0 부터는 옵션을 켜기만 하면 SDK에서 자동으로 위치 정보를 얻어옵니다.
// 자신의 앱에 보다 적한한 광고를 노출 시키고 싶은 개발자 분들은 아래 메소드의 리턴값을 TRUE로 설정하시기 바랍니다. 경우에 따라 광고 수입이 늘어 날 수 있습니다.
// 단, 이 경우 위치정보 사용에 대한 사용자 동의를 얻는 절차가 수반됩니다.
- (BOOL) getGPSInfo;
// 기존에 사용하던 위치 정보 전달 메소드. 2.1.0부터는 기능 없음.
- (NSString *) gps; // 위도,경도

- (BOOL) dynamicReloadInterval;     //디폴트롤링주기

//--- 광고 형태 셋팅 메소드
- (REFRESH_PERIOD) rollingPeriod;	// CPC광고 교체주기 REFRESH_PERIOD Type값을 설정합니다.
- (ANIMATION_TYPE) animationType;	// CPC광고 교체시 광고가 나오는 애니메이션 설정 ANIMATION_TYPE type값을 설정합니다.


//--- callback 메소드
- (void)AdReceiveCompleted; // 광고를 정상적으로 수신하고 뷰를 생성한 후에 마지막으로 AdReceiveCompleted를 호출합니다.
- (void)AdReceiveFailed;	// 광고를 얻어 오는데 실패하게 되면 호출됩니다.
- (void)closeCPMAd;			// CPM광고를 클릭하여 CPM 광고가 사라지고 나서 호출됩니다.

@end
