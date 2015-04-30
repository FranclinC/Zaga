//
//  MapViewController.h
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;
@end
