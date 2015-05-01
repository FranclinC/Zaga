//
//  MainViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
{
    NSArray *stadiums;
    //NSArray *nicks;
    NSArray *images;
}

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    images = [[NSArray alloc] initWithObjects:@"ilha.png", @"Arruda.png", @"Arena.png", nil];
    stadiums = @[@"Ilha do Retiro", @"Arruda", @"Aflitos"];
    //nicks = @[@"Estádio Adelmar da Costa Carvalho", @"Estádio José do Rego Maciel", @"Estádio Eládio de Barros Carvalho"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [stadiums count];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.imageView.layer.cornerRadius = cell.imageView.frame.size.width / 2.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString *stadium = [stadiums objectAtIndex:indexPath.row];
    //NSString *nick = [nicks objectAtIndex:indexPath.row];
    
    cell.textLabel.text = stadium;
    cell.imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    
    return cell;
}

@end