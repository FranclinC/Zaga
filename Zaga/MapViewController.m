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
@property NSArray * nomeRelatos;
@property MKPointAnnotation * pin;
@property (weak, nonatomic) IBOutlet UIButton *refresh;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UILabel *Title;


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
    
    //Initialize initial stadiums
    _latituteEstadios = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble: -8.04065],[NSNumber numberWithDouble: -8.06260769],[NSNumber numberWithDouble: -8.026699], nil];
    _longitudeEstadios = [[NSArray alloc] initWithObjects:[NSNumber numberWithDouble: -35.008205],
                          [NSNumber numberWithDouble: -34.9031353],[NSNumber numberWithDouble: -34.891111], nil];
    _nomesEstadios = [[NSArray alloc]initWithObjects:@"Arena PE",@"Ilha do Retiro",@"Arruda", nil];
    _nomeRelatos = [[NSArray alloc] initWithObjects:@"Policia",@"Assaltos",@"Tumulto",@"Organizadas", nil];
    //Init Cloud
    _cp = [[CloudProvider alloc] init];
    _loading.hidden = YES;
    //_loading.areAnimationsEnabled
    [self showRelatos];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showRelatos{
    
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
            //[self viewDidAppear:YES];
        }
        });
    })];

}
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKAnnotationView*    pinView = (MKAnnotationView*)[mapView
dequeueReusableAnnotationViewWithIdentifier:@"CustomPinAnnotationView"];
        
        if (!pinView)
        {
            // If an existing pin view was not available, create one.
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomPinAnnotationView"];
            pinView.canShowCallout = YES;
            
            //pinView.leftCalloutAccessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"policia"]];
            NSLog(@"Era pra tar com uma imagem");
            
            // If appropriate, customize the callout by adding accessory views (code not shown).
        }
        else
            pinView.annotation = annotation;
        
        pinView.image = [UIImage imageNamed:@"Policia"];
        NSLog(@"Era pra tar com uma imagem");
        
        return pinView;
    }
    return nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [self refresh];
    CLLocationCoordinate2D myCoordinate = {[[_latituteEstadios objectAtIndex:mapIndex] doubleValue], [[_longitudeEstadios objectAtIndex:mapIndex] doubleValue]};

    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(myCoordinate, 1050, 1050);
    [self.mapview setRegion:viewRegion animated:YES];
    [self.mapview removeAnnotation:_pin];
    _pin = [[MKPointAnnotation alloc] init];
    _pin.coordinate = myCoordinate;
    _pin.title = [_nomesEstadios objectAtIndex:mapIndex];
    [self showRelatos];
    _Title.text =[_nomesEstadios objectAtIndex:mapIndex];
        
}

// BUTTON ACTION
- (IBAction)refresh:(id)sender {
    [self showRelatos];

}



@end