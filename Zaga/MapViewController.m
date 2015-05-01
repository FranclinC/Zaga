//
//  MapViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic) CGPoint centerOffset;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (nonatomic) UIImage  *image;
@property (weak, nonatomic) IBOutlet UIButton *report;
@property (strong,nonatomic) NSArray* latituteEstadios;
@property (strong,nonatomic) NSArray* longitudeEstadios;
@property (strong ,nonatomic) NSArray* nomesEstadios;
@property MKPointAnnotation * pin;


@end

@implementation MapViewController

static int mapIndex =1;

+(void)setMapIndex:(int)val{
    mapIndex = val;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    //[self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    [self.mapView showsUserLocation];
    self.mapView.delegate = self;
    
    _latituteEstadios = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble: -8.04065],
                         [NSNumber numberWithDouble: -8.06260769],[NSNumber numberWithDouble: -8.026699]
                         , nil];
    _longitudeEstadios = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble: -35.008205],
                          [NSNumber numberWithDouble: -34.9031353],[NSNumber numberWithDouble: -34.891111], nil];
    _nomesEstadios = [[NSArray alloc]initWithObjects:@"Arena PE",@"Ilha do Retiro",@"Arruda", nil];
    
    //for (int i = 0; i<3; i++) {
    
        
    //}
    
}


- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKAnnotationView class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView*    pinView = (MKPinAnnotationView*)[mapView
                       dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            
            // If appropriate, customize the callout by adding accessory views (code not shown).
        }
        else
            pinView.annotation = annotation;
        
        return pinView;
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated{
    CLLocationCoordinate2D myCoordinate = {[[_latituteEstadios objectAtIndex:mapIndex] doubleValue], [[_longitudeEstadios objectAtIndex:mapIndex] doubleValue]};

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, 1050, 1050);
    [self.mapview setRegion:viewRegion animated:YES];
    [self.mapview removeAnnotation:_pin];
    _pin = [[MKPointAnnotation alloc] init];
    _pin.coordinate = myCoordinate;
    _pin.title = [_nomesEstadios objectAtIndex:mapIndex];
    [self.mapview addAnnotation:_pin];
}



@end