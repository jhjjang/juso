//
//  ResultViewController.h
//  juso
//
//  Created by jungho jang on 12. 1. 16..
//  Copyright (c) 2012년 INCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "addressItem.h"

#define saveFile @"address"

@interface ResultViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate,MKAnnotation,MFMessageComposeViewControllerDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *addressPoint;
    CLLocationCoordinate2D coordinate;    
    MKMapView *mapView;
    MKPlacemark *mPlacemark;

    NSMutableData *receiveData;
    NSURLConnection *connection;
    addressItem *item;
    UITextView *address1;
    UITextView *address2;
    NSString *resultPosition;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSMutableData *receiveData;
@property (nonatomic, retain) NSURLConnection *connection;
@property (strong, retain) addressItem *item;
@property (strong, retain) IBOutlet UITextView *address1;
@property (strong, retain) IBOutlet UITextView *address2;
@property (strong, nonatomic) IBOutlet UILabel *zipcode;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManger;
@property (strong, nonatomic) CLLocation *addressPoint;
@property (strong, retain) NSString *resultPosition;
@property (strong, nonatomic) MKPlacemark *mPlacemark;



- (IBAction)closeView:(id)sender;
- (IBAction)saveAddress:(id)sender;
- (IBAction)sendSMS:(id)sender;
- (IBAction)copyAddress:(id)sender;
-(void)requestPosition;
-(void)setPosition;
-(NSString *)dataFilePath;
@end
