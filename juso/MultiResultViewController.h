//
//  MultiResultViewController.h
//  juso
//
//  Created by jungho jang on 12. 1. 20..
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
@interface MultiResultViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate,MKMapViewDelegate,MKAnnotation,MFMessageComposeViewControllerDelegate>
{
    UIToolbar *toolbar;
    CLLocationManager *locationManager;
    CLLocation *addressPoint;
    CLLocationCoordinate2D coordinate;    
    MKMapView *mapView;
    MKPlacemark *mPlacemark;
    UITableView *table;
    
    NSMutableArray *addressObjects;
    addressItem *addr;
    NSString *address1;
    NSString *address2;
    
    NSMutableData *receiveData;
    NSURLConnection *connection;
    
    NSMutableArray *arrayLatitude;
    NSMutableArray *arrayLongitude;
    NSMutableArray *radioButtonArray;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) CLLocationManager *locationManger;
@property (strong, nonatomic) CLLocation *addressPoint;
@property (strong, retain) NSString *resultPosition;
@property (strong, nonatomic) MKPlacemark *mPlacemark;
@property (strong, nonatomic) NSMutableArray *addressObjects;
@property (strong, nonatomic) addressItem *addr;
@property (strong, nonatomic) NSString *address1;
@property (strong, nonatomic) NSString *address2;
@property (nonatomic, retain) NSMutableData *receiveData;
@property (nonatomic, retain) NSURLConnection *connection;

@property (strong, nonatomic) NSMutableArray *arrayLatitude;
@property (strong, nonatomic) NSMutableArray *arrayLongitude;
@property (strong, nonatomic) NSMutableArray *radioButtonArray;

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *toolbarTitle;

-(void)saveAddress:(id)sender;
-(void)setPosition;
-(NSString *)getSelectAddr;
-(IBAction)sendSMS:(id)sender;
-(IBAction)copyAddress:(id)sender;

@end
