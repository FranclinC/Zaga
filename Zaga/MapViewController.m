//
//  MapViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (nonatomic, strong) MKPointAnnotation *annotation;

@end

@implementation MapViewController

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _annotation = [[MKPointAnnotation alloc] init];
    _searchField.delegate = self;
    _mapView.delegate = self;
    
    _locationManager = [[CLLocationManager alloc] init];
    
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])){
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [_locationManager requestAlwaysAuthorization];
            }else if ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUsageDescription"]){
                [self.locationManager  requestWhenInUseAuthorization];
            }else{
                NSLog(@"Info.plist does not contain NSLocaionAlwaysUsageDescription or NSLocationWhenInUsageDescription");
            }
            
        }
    }
    MKCoordinateRegion region;
    CLLocationCoordinate2D newLocation = CLLocationCoordinate2DMake(-8.0620769, -34.9031353);
    region.center = newLocation;
    //MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [_annotation setCoordinate:newLocation];
    [_mapView addAnnotation:_annotation];
       
    MKMapRect mr = [_mapView visibleMapRect];
    MKMapPoint pt = MKMapPointForCoordinate([_annotation coordinate]);
    mr.origin.x = pt.x - mr.size.width * 0.5;
    mr.origin.y = pt.y - mr.size.height *0.25;
    [_mapView setVisibleMapRect:mr animated:YES];
    
    [_locationManager startUpdatingLocation];
    
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        _longitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _latitudeLabel.text = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
    }
}




//It zoom in in the location
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    
    [mapView setRegion:mapRegion animated:YES];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [_searchField resignFirstResponder];
    
    CLGeocoder *geocoder =[[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_searchField.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        
        MKCoordinateRegion region;
        CLLocationCoordinate2D newLocation = [placemark.location coordinate];
        region.center = [(CLCircularRegion *) placemark.region center];
        
        //MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [_mapView removeAnnotation:_annotation];
        [_annotation setCoordinate:newLocation];
        [_annotation setTitle:_searchField.text];
        [_mapView addAnnotation: _annotation];
        //        [_mapView removeAnnotation:_annotation];
        
        MKMapRect mr = [_mapView visibleMapRect];
        MKMapPoint pt = MKMapPointForCoordinate([_annotation coordinate]);
        mr.origin.x = pt.x - mr.size.width * 0.5;
        mr.origin.y = pt.y - mr.size.height *0.25;
        [_mapView setVisibleMapRect:mr animated:YES];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end