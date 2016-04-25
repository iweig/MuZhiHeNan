//
//  GWNavigationController.h
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWNavigationController : UINavigationController

@property (nonatomic, strong) UINavigationBar *navBar;

@property (nonatomic, strong) UINavigationItem *navigationItem;

- (void)setNavigationBarBackgroundImage;

- (void)setNavTitle:(NSString *)title;

@end
