//
//  GWNewsDetailViewController.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/3.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsDetailViewController.h"

@interface GWNewsDetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GWNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)setupUI
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 20)];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
}

#pragma mark -UITableViewDataSource

#pragma mark -UITableViewDelegate

@end
