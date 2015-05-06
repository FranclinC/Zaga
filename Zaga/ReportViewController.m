//
//  ReportViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "ReportViewController.h"
#import "MapViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)policiaAction:(id)sender
{
    [MapViewController showCenter:YES];
    [MapViewController setTypeAdd:0];
    MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"GoMap"];
    [self.navigationController pushViewController:tempView animated:YES];
}

- (IBAction)rouvoAction:(id)sender
{
    [MapViewController showCenter:YES];
    [MapViewController setTypeAdd:1];
    MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"GoMap"];
    [self.navigationController pushViewController:tempView animated:YES];
    
}

- (IBAction)organizadasAction:(id)sender
{
    [MapViewController showCenter:YES];
    [MapViewController setTypeAdd:3];
    MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"GoMap"];
    [self.navigationController pushViewController:tempView animated:YES];
}

- (IBAction)brigaAction:(id)sender
{
    [MapViewController showCenter:YES];
    [MapViewController setTypeAdd:2];
    MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"GoMap"];
    [self.navigationController pushViewController:tempView animated:YES];
}

@end