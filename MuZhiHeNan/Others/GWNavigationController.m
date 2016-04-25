//
//  GWNavigationController.m
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNavigationController.h"
#import "GWThemeManager.h"

@interface GWNavigationController () <UIGestureRecognizerDelegate>




@end

@implementation GWNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        //取消系统的导航栏
        self.navigationBarHidden = YES;
        UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 64)];
        navBar.tintColor = [UIColor whiteColor];
        [self.view addSubview:navBar];
        
        //初始化title
        UINavigationItem *titleItem = [[UINavigationItem alloc] init];
        [navBar pushNavigationItem:titleItem animated:NO];
        
        self.navigationItem = titleItem;
                    
        self.navBar = navBar;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    [self.navBar setBackgroundImage:[[GWThemeManager shareThemeManager] imageWithNameString:@"toolbar_bg"] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    self.navigationItem.title = @"";
}

/**
 *  设置导航栏的title
 *
 *  @param title 传入title
 */
- (void)setNavTitle:(NSString *)title
{
    self.navigationItem.title = title;
}


@end
