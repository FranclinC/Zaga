//
//  MapViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MapViewController.h"

#define PIN_HEIGHT_OFFSET 5
#define PIN_WIDTH_OFFSET 7.75

@interface MapViewController ()

@property (nonatomic) CGPoint centerOffset;
@property (weak, nonatomic) IBOutlet MKMapView *mapview;
@property (nonatomic) UIImage  *image;
@property (weak, nonatomic) IBOutlet UIButton *report;
@property (strong,nonatomic) NSArray* latituteEstadios;
@property (strong,nonatomic) NSArray* longitudeEstadios;
@property (strong ,nonatomic) NSArray* nomesEstadios;
@property NSArray * nomeRelatos;
@property MKPointAnnotation * pin;
@property (weak, nonatomic) IBOutlet UIButton *refresh;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (strong, nonatomic) MKAnnotationView *centerAnnotationView;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleFromBar;

@end

@implementation MapViewController

static int mapIndex =1;
static int typeAdd=0;
static BOOL showCenterAnnotation = 0;

+(void)setMapIndex:(int)val
{
    mapIndex = val;
}

+(void)showCenter:(BOOL)vall
{
    showCenterAnnotation = vall;
}

+(void)setTypeAdd:(int)val
{
    typeAdd = val;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mapView addSubview:self.centerAnnotationView];
    _centerAnnotationView.hidden = YES;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    [self.mapView showsUserLocation];
    self.mapView.delegate = self;
    
    _latituteEstadios = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble: -8.04065],[NSNumber numberWithDouble: -8.06260769],[NSNumber numberWithDouble: -8.026699], nil];
    _longitudeEstadios = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble: -35.008205], [NSNumber numberWithDouble: -34.9031353],[NSNumber numberWithDouble: -34.891111], nil];
    _nomesEstadios = [[NSArray alloc]initWithObjects:@"Arena PE",@"Ilha do Retiro",@"Arruda", nil];
    _nomeRelatos = [[NSArray alloc] initWithObjects:@"Polícia",@"Assaltos",@"Briga",@"Organizadas", nil];
    
    _cp = [[CloudProvider alloc] init];
    _loading.hidden = YES;
    
    [self showRelatos];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showRelatos
{
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:[[_latituteEstadios objectAtIndex:mapIndex] doubleValue] longitude:[[_longitudeEstadios objectAtIndex:mapIndex] doubleValue]];
    _loading.hidden = NO;
    
    [_cp queryRelato:loc handler:(^(NSMutableArray* arr, NSError * error){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView removeAnnotations:self.mapView.annotations];
        if (error) {
            NSLog(@"Deu ruim!!");
        }else{
            for(Relato *record in arr){
                MKPointAnnotation* anno = [[MKPointAnnotation alloc]init];
                anno.coordinate = record.position.coordinate;
                anno.title = [_nomeRelatos objectAtIndex:[record.type integerValue]];
                [self.mapview addAnnotation:anno];
            }
            
            [self.tabBarController setSelectedIndex:1];
            _loading.hidden = YES;
            [self.mapview addAnnotation:_pin];
            if(showCenterAnnotation){
                _centerAnnotationView.hidden = NO;
            }
            else{
                _centerAnnotationView.hidden = YES;
            }
        }
        });
    })];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;

    if ([annotation isKindOfClass:[MKPointAnnotation class]]){
        MKAnnotationView*    pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView){
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
        }else{
            pinView.annotation = annotation;
        }
        
        MKPointAnnotation* pointA = (MKPointAnnotation*)annotation;
        
        if([pointA.title isEqualToString:@"Polícia"]){
            pinView.image = [UIImage imageNamed:@"Policia"];
        }else if([pointA.title isEqualToString:@"Assaltos"]){
            pinView.image = [UIImage imageNamed:@"Assaltos"];
        }else if([pointA.title isEqualToString:@"Briga"]){
            pinView.image = [UIImage imageNamed:@"Briga"];
        }else if([pointA.title isEqualToString:@"Organizadas"]){
            pinView.image = [UIImage imageNamed:@"Organizadas"];
        }else{
            pinView.image = [UIImage imageNamed:@"Estadio"];
        }
        
        return pinView;
    }
    
    return nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self refresh];
    CLLocationCoordinate2D myCoordinate = {[[_latituteEstadios objectAtIndex:mapIndex] doubleValue], [[_longitudeEstadios objectAtIndex:mapIndex] doubleValue]};
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, 1050, 1050);
    
    if(typeAdd ==0){
        _centerAnnotationView.image = [UIImage imageNamed:@"Policia"];
    }else if (typeAdd == 1){
        _centerAnnotationView.image = [UIImage imageNamed:@"Assaltos"];
    } else if (typeAdd ==2){
        _centerAnnotationView.image = [UIImage imageNamed:@"Briga"];
    }else {
        _centerAnnotationView.image = [UIImage imageNamed:@"Organizadas"];
    }
    
    [self.mapview setRegion:viewRegion animated:YES];
    [self.mapview removeAnnotation:_pin];
    _pin = [[MKPointAnnotation alloc] init];
    _pin.coordinate = myCoordinate;
    _pin.title = [_nomesEstadios objectAtIndex:mapIndex];
    _centerAnnotation.title = @"CenterAnotation";
    [self showRelatos];
    _titleFromBar.title = [_nomesEstadios objectAtIndex:mapIndex];
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)refresh:(id)sender
{
    [self showRelatos];
}

- (MKPointAnnotation *)centerAnnotation
{
    if (!_centerAnnotation) {
        _centerAnnotation = [[MKPointAnnotation alloc] init];
    }
    
    return _centerAnnotation;
}

- (MKAnnotationView *)centerAnnotationView
{
    if (!_centerAnnotationView)
        _centerAnnotationView = [[MKAnnotationView alloc] initWithAnnotation:self.centerAnnotation reuseIdentifier:@"centerAnnotationView"];
    
    return _centerAnnotationView;
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self.centerAnnotation setCoordinate:mapView.centerCoordinate];
    [self moveMapAnnotationToCoordinate:mapView.centerCoordinate];
}

-(void)moveMapAnnotationToCoordinate:(CLLocationCoordinate2D)coordinate
{
    CGPoint mapViewPoint = [self.mapView convertCoordinate:coordinate toPointToView:self.mapView];
    CGFloat xoffset = CGRectGetMidX(self.centerAnnotationView.bounds) - PIN_WIDTH_OFFSET;;
    CGFloat yoffset = -CGRectGetMidY(self.centerAnnotationView.bounds)+ PIN_HEIGHT_OFFSET;;
    self.centerAnnotationView.center = CGPointMake(mapViewPoint.x + xoffset,mapViewPoint.y + yoffset);
}

- (IBAction)cancelaAction:(id)sender
{
    showCenterAnnotation = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)confirmaAction:(id)sender
{
    showCenterAnnotation = NO;
    Relato * rela  = [[Relato alloc] init];
    rela.type = [[NSNumber alloc] initWithInteger:typeAdd];
    rela.position = [[CLLocation alloc] initWithLatitude:_centerAnnotation.coordinate.latitude longitude:_centerAnnotation.coordinate.longitude];
    
    [_cp addRelato:rela];
    dispatch_async(dispatch_get_main_queue(), ^{
        MKPointAnnotation* anno = [[MKPointAnnotation alloc]init];
        MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"InitMap"];
        anno.coordinate = rela.position.coordinate;
        anno.title = [_nomeRelatos objectAtIndex:[rela.type integerValue]];
        [tempView.mapview addAnnotation:anno];
    });
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

@end