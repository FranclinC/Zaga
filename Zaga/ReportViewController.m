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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)policiaAction:(id)sender {
    [MapViewController showCenter:YES];
    [MapViewController setTypeAdd:0];
    MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"GoMap"];
    [self.navigationController pushViewController:tempView animated:YES];
    //[self.navigationController popViewControllerAnimated:YES];
    //[self.navigationController performSegueWithIdentifier:@"goMap" sender:sender];
    
}

- (IBAction)rouvoAction:(id)sender {
    [MapViewController showCenter:YES];
    [MapViewController setTypeAdd:1];
    MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"GoMap"];
    [self.navigationController pushViewController:tempView animated:YES];
    
}
- (IBAction)organizadasAction:(id)sender {
    [MapViewController showCenter:YES];
    [MapViewController setTypeAdd:3];
    MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"GoMap"];
    [self.navigationController pushViewController:tempView animated:YES];
}
- (IBAction)brigaAction:(id)sender {
    [MapViewController showCenter:YES];
    [MapViewController setTypeAdd:2];
    MapViewController *tempView =[self.storyboard instantiateViewControllerWithIdentifier:@"GoMap"];
    [self.navigationController pushViewController:tempView animated:YES];
    //[self.navigationController performSegueWithIdentifier:@"goMap" sender:sender];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
