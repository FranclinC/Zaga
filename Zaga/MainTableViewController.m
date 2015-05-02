//
//  MainTableViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 5/1/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MainTableViewController.h"
#import "MapViewController.h"

@interface MainTableViewController ()
{
    NSArray *stadiums;
    NSArray *images;
}

@end

@implementation MainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    images = [[NSArray alloc] initWithObjects:@"Arena.png",@"ilha.png", @"Arruda.png",  nil];
    stadiums = @[@"Arena PE",@"Ilha do Retiro", @"Arruda"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [stadiums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSString *stadium = [stadiums objectAtIndex:indexPath.row];
    
    cell.textLabel.text = stadium;
    cell.imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Estádios";
}
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MapViewController setMapIndex:indexPath.row];
}

@end