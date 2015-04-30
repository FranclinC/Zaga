//
//  MapViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapViewController.h"
#import "LocationDataController.h"
#import "Location.h"
#import "Report.h"

#define METERS_PER_MILE 1609.344
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController ()

@property (nonatomic) CGPoint centerOffset;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (nonatomic) UIImage  *image;
@property (weak, nonatomic) IBOutlet UIButton *report;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    [self.mapView showsUserLocation];
    self.mapView.delegate = self;
    
    CLLocationCoordinate2D myCoordinate = {-8.06260769, -34.9031353};
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = myCoordinate;
    pin.title = @"Policia";
    [self.mapview addAnnotation:pin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If it's the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView *pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            //pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            pinView.image = [UIImage imageNamed:@"polícia.png"];
            pinView.calloutOffset = CGPointMake(0, 32);
        } else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
    
    return nil;
}

- (void)viewDidAppear:(BOOL)animated{
    LocationDataController *model = [[LocationDataController alloc]init];
    Location *p = [model getPointOfInterest];
    CLLocationCoordinate2D poooiCoodinates;
    poooiCoodinates.latitude = p.latitude;
    poooiCoodinates.longitude = p.longitude;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(poooiCoodinates, 900, 1050);
    [self.mapview setRegion:viewRegion animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

@end