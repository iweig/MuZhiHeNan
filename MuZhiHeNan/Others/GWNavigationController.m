//
//  GWNavigationController.m
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNavigationController.h"
#import "GWThemeManager.h"
#import "UIImage+Utilities.h"

@interface GWNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>


@end

@implementation GWNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController])
    {
        self.navigationBar.tintColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTitle];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -100) forBarMetrics:UIBarMetricsDefault];
    kWeakSelf
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

/**
 *  设置viewController导航栏背景色
 */
- (void)setNavigationBarBackgroundImage
{
    UIImage *image = [[GWThemeManager shareThemeManager] imageWithNameString:@"toolbar_bg"];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

//重写系统的push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
    viewController.hidesBottomBarWhenPushed = NO;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{

    UIViewController *viewController = [super popViewControllerAnimated:animated];
    
    if (self.viewControllers.count == 2)
    {
        viewController.tabBarController.tabBar.hidden = YES;
    }
    
    else if(self.viewControllers.count == 1)
    {
        self.delegate = self;
    }
    
    return viewController;
}

/**
 *  配置title的样式
 */
- (void)setupTitle
{
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]};
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark -UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.tabBarController.tabBar.hidden = NO;
    self.delegate = nil;
}

@end
