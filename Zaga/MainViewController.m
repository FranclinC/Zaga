//
//  MainViewController.m
//  Zaga
//
//  Created by Miguel Araújo on 4/28/15.
//  Copyright (c) 2015 Miguel Araújo. All rights reserved.
//

#import "MainViewController.h"
#import "MapViewController.h"
@interface MainViewController ()
{
    NSArray *tableData;
    NSArray *stadiumsIm;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableData = [NSArray arrayWithObjects:@"Arena PE", @"Ilha do Retiro", @"Arruda", nil];

    _tableView.delegate = self;
    _tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [MapViewController setMapIndex:indexPath.row ];
    
    [self.tabBarController setSelectedIndex:1];
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return  NSLocalizedString(@"Lista de Estádios", @"Lista de Estádios");

}

@end
