//
//  GWBaseViewController.m
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWBaseViewController.h"
#import "GWMeViewController.h"
#import "GWTabBarManager.h"

@implementation GWBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpNav];
}

- (void)setUpNav
{
    //初始化nav leftNavigationItem
    UIBarButtonItem *meItem = [[UIBarButtonItem alloc] initWithImage:[[GWBundleManager shareBundleManager] imageWithName:@"DashboardTabBarItemProfile" bundleString:@"theme_default"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.navigationItem.leftBarButtonItem = meItem;
    //设置导航栏颜色
}



- (void)leftItemClick
{
    [self.navigationController pushViewController:[[GWMeViewController alloc] init] animated:YES];
}


@end
