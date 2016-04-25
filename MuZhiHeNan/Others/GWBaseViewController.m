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
    [self setupTitle];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[GWTabBarManager shareTabBarManager] tabBarHindden:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUpNav];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [[GWTabBarManager shareTabBarManager] tabBarHindden:YES];
}


- (void)setUpNav
{
    //初始化nav leftNavigationItem
    UIBarButtonItem *meItem = [[UIBarButtonItem alloc] initWithImage:[[GWBundleManager shareBundleManager] imageWithName:@"DashboardTabBarItemProfile" bundleString:@"theme_default"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    self.customNavigationController.navigationItem.leftBarButtonItem = meItem;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (GWNavigationController *)customNavigationController
{
    return (GWNavigationController *)self.navigationController;
}

/**
 *  配置title的样式
 */
- (void)setupTitle
{
    self.customNavigationController.navBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:21.0],NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (void)leftItemClick
{
    [self.customNavigationController pushViewController:[[GWMeViewController alloc] init] animated:YES];
}


@end
