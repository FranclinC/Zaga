//
//  MainTableViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 5/1/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MainTableViewController.h"

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
    images = [[NSArray alloc] initWithObjects:@"ilha.png", @"Arruda.png", @"Arena.png", nil];
    stadiums = @[@"Ilha do Retiro", @"Arruda", @"Aflitos"];
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

@end