//
//  MapViewController.h
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#import "CloudProvider.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property CloudProvider* cp;
@property (strong, nonatomic) MKPointAnnotation *centerAnnotation;
@property (weak, nonatomic) IBOutlet UIButton *confirma;
@property (weak, nonatomic) IBOutlet UIButton *Cancela;

+(void)setMapIndex:(int)val;
+(void)showCenter:(BOOL)val;
+(void)setTypeAdd:(int)val;

@end