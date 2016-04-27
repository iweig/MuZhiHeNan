//
//  GWTabBarManager.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWTabBarManager.h"
#import "GWHomeViewController.h"
#import "GWAppViewController.h"
#import "GWHotNewsViewController.h"
#import "GWMeViewController.h"
#import "GWBundleManager.h"
#import "GWThemeManager.h"

@implementation GWTabBarManager

static GWTabBarManager *tabBarManager;

+ (instancetype)shareTabBarManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarManager = [[GWTabBarManager alloc] init];
        tabBarManager.tabBarController = [[UITabBarController alloc] init];
    });
    return tabBarManager;
}

- (void)setupTabBar:(UIWindow *)window
{
    //初始化首页ViewController
    GWHomeViewController *homeVC = [[GWHomeViewController alloc] init];
    homeVC.tabBarItem.title = @"订阅";
    homeVC.tabBarItem.image = [GWBundleManager imageWithName:@"DashboardTabBarItemSubscription" bundleString:@"theme_default"];
    UINavigationController *homeNav = [[GWNavigationController alloc] initWithRootViewController:homeVC];
    
    //初始化热点ViewController
    GWHotNewsViewController *hotnewsVC = [[GWHotNewsViewController alloc] init];
    hotnewsVC.tabBarItem.title = @"热点";
    hotnewsVC.tabBarItem.image = [GWBundleManager imageWithName:@"DashboardTabBarItemDailyHot" bundleString:@"theme_default"];
    UINavigationController *hotnewsNav = [[GWNavigationController alloc] initWithRootViewController:hotnewsVC];
    
    //初始化应用ViewCotroller
    GWAppViewController *appVC = [[GWAppViewController alloc] init];
    appVC.tabBarItem.title = @"应用";
    appVC.tabBarItem.image = [GWBundleManager imageWithName:@"DashboardTabbarLife" bundleString:@"theme_default"];
    UINavigationController *appNav = [[GWNavigationController alloc] initWithRootViewController:appVC];
    
    //将tabBarController做为window的根视图控制器
    self.tabBarController.viewControllers = @[homeNav, hotnewsNav, appNav];
    window.rootViewController = self.tabBarController;
    
    //设置app主题
    [[GWThemeManager shareThemeManager] setupThemeStyle];
}

- (void)tabBarHindden:(BOOL)isHidden
{
    self.tabBarController.tabBar.hidden = isHidden;
}



@end
