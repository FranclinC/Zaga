//
//  ViewController.h
//  MiniChallenge
//
//  Created by Franclin Cabral on 29/04/15.
//  Copyright (c) 2015 Franclin Cabral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchField;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;

@end
