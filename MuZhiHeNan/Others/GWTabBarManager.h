//
//  GWTabBarManager.h
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GWTabBarManager : NSObject

@property (nonatomic, strong) UITabBarController *tabBarController;

+ (instancetype)shareTabBarManager;

- (void)setupTabBar:(UIWindow *)window;

- (void)tabBarHindden:(BOOL)isHidden;

@end
