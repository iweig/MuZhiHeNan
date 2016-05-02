//
//  GWHotNewsViewController.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWHotNewsViewController.h"

@interface GWHotNewsViewController ()

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation GWHotNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.title = @"热点";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
