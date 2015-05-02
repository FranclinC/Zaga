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

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation MainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    images = [[NSArray alloc] initWithObjects:@"Arena.png",@"ilha.png", @"Arruda.png",  nil];
    stadiums = @[@"Arena PE",@"Ilha do Retiro", @"Arruda"];
    [self.navigationController setNavigationBarHidden:NO];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.tableView.delegate = self;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [stadiums objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[images objectAtIndex:indexPath.row]];
    cell.imageView.layer.cornerRadius =  30;
    cell.imageView.layer.masksToBounds = YES;
    [self.navigationController setTitle:@"Zaga"];
    
    return cell;
}

-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [MapViewController setMapIndex:indexPath.row];
    
    [self.tabBarController setSelectedIndex:1];
}

@end