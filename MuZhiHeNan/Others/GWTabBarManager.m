//
//  GWTabBarManager.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWTabBarManager.h"
#import "GWSubscriberViewController.h"
#import "GWAppViewController.h"
#import "GWHotNewsViewController.h"
#import "GWMeViewController.h"

@implementation GWTabBarManager

static GWTabBarManager *tabBarManager;

+ (instancetype)shareTabBarManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarManager = [[GWTabBarManager alloc] init];
    });
    return tabBarManager;
}

- (void)setupTabBar
{
    self.tabBarController = [[UITabBarController alloc] init];
    
    //初始化首页ViewController
    
    //初始化热点ViewController
    
    //初始化应用ViewCotroller
    
    //初始化我的ViewController
    
    
}

@end
