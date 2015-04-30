//
//  MapViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapViewController.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addAnnotation];
    
    
    self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(checkStatus)
                                   userInfo:nil repeats:YES];
    
    self.mapView.delegate = self;
}

-(void) addAnnotation{
    NSMutableArray *anotations = [[NSMutableArray alloc] init];
    
    MKPointAnnotation *pointOne = [[MKPointAnnotation alloc] init];
    pointOne.coordinate = CLLocationCoordinate2DMake(-8.049965, -34.958638);
    pointOne.title = @"JJ Estética";
    
    [anotations addObject:pointOne];
    
    MKPointAnnotation *pointTwo = [[MKPointAnnotation alloc] init];
    pointTwo.coordinate = CLLocationCoordinate2DMake(-8.043763, -34.947463);
    pointTwo.title = @"Alternativo Cabelereiro";
    
    [anotations addObject:pointTwo];
    
    MKPointAnnotation *pointThree = [[MKPointAnnotation alloc] init];
    pointThree.coordinate = CLLocationCoordinate2DMake(-8.049786, -34.959485);
    pointThree.title = @"Ella’s Estética e Beleza";
    
    [anotations addObject:pointThree];
    
    MKPointAnnotation *pointFour = [[MKPointAnnotation alloc] init];
    pointFour.coordinate = CLLocationCoordinate2DMake(-8.043531, -34.941061);
    pointFour.title = @"Mércia Cabelereira Unissex";
    
    [anotations addObject:pointFour];
    
    MKPointAnnotation *pointFive = [[MKPointAnnotation alloc] init];
    pointFive.coordinate = CLLocationCoordinate2DMake(-8.058180, -34.942402);
    pointFive.title = @"Douglas Cabelereiro";
    
    [anotations addObject:pointFive];
    
    [self.mapView addAnnotations:anotations];
}

-(void) checkStatus{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    NSString *valueStatus = @"";
    
    if (status==kCLAuthorizationStatusNotDetermined) {
        //_status.text = @"Not Determined";
        valueStatus = @"Not Determined";
    }
    
    if (status==kCLAuthorizationStatusDenied) {
        //_status.text = @"Denied";
        valueStatus = @"Denied";
    }
    
    if (status==kCLAuthorizationStatusRestricted) {
        //_status.text = @"Restricted";
        valueStatus = @"Restricted";
    }
    
    if (status==kCLAuthorizationStatusAuthorizedAlways) {
        //_status.text = @"Always Allowed";
        valueStatus = @"Always Allowed";
        self.mapView.showsUserLocation = YES;
    }
    
    if (status==kCLAuthorizationStatusAuthorizedWhenInUse) {
        //_status.text = @"When In Use Allowed";
        valueStatus = @"When In Use Allowed";
        self.mapView.showsUserLocation = YES;
    }
    
    NSLog(valueStatus);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
