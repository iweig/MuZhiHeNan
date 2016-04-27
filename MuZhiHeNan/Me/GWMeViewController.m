//
//  GWMeViewController.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWMeViewController.h"
#import "GWTestViewController.h"

@interface GWMeViewController ()

@end

@implementation GWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    self.navigationItem.title = @"我";
}

- (IBAction)btnClick:(id)sender
{
    [self.navigationController pushViewController:[[GWTestViewController alloc] init] animated:YES];
    
}

@end
