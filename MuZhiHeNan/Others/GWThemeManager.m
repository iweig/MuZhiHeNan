//
//  GWThemeManager.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWThemeManager.h"
#import "GWTabBarManager.h"

@interface GWThemeManager ()

//当前的主题包
@property (nonatomic, strong) NSString *themeBundle;

//主题包数组
@property (nonatomic, strong) NSArray *themeArr;

//主题包样式配色
@property (nonatomic, strong) NSArray *themeColor;

@end

@implementation GWThemeManager


/**
 *  懒加载数据
 */
- (NSArray *)themeArr
{
    if (!_themeArr) {
        _themeArr = @[@"theme_red",@"theme_pink",@"theme_blue"];
    }
    return _themeArr;
}

- (NSArray *)themeColor
{
    if (!_themeColor) {
        _themeColor = @[[UIColor redColor],[UIColor colorWithRed:1 green:0 blue:156 / 255.0 alpha:1.0],[UIColor blueColor]];
    }
    return _themeColor;
}

static GWThemeManager *themeManager;

+ (instancetype)shareThemeManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        themeManager = [[GWThemeManager alloc] init];
    });
    [themeManager initCurrentTheme];
//    [themeManager setupThemeStyle];
    return themeManager;
}

/**
 *  初始化主题
 */
- (void)initCurrentTheme
{
    NSInteger type = [self getThemeType];
    [self setTHemeType:type];
}

/**
 *  设置当前主题
 *
 *  @param type <#type description#>
 */
- (void)setTHemeType:(NSInteger)type
{
    self.themeBundle = [[NSBundle mainBundle] pathForResource:self.themeArr[type] ofType:@"bundle"];
    //保存themeType
    [self saveThemeType:type];
}

/**
 *  通过图片名称获取图片资源
 *
 *  @param imageStr 图片名称
 *
 *  @return UIImage对象
 */
- (UIImage *)imageWithNameString:(NSString *)imageStr
{
    
    NSString *imageName = [[NSBundle bundleWithPath:self.themeBundle] pathForResource:imageStr ofType:@"png"];
    if (imageName) {
        return [UIImage imageNamed:imageName];
    }
    NSAssert(imageName, @"主题图片不能为空");
    return [UIImage imageNamed:@""];
}

/**
 *  获取当前tabBar的tintColor
 *
 *  @return <#return value description#>
 */
- (UIColor *)themeTintColor
{
    return self.themeColor[[self getThemeType]];
}

//获取当前主题iD
- (NSInteger)getThemeType
{
    kUserDefaults
    return [[userDefaults valueForKey:@"themeType"] integerValue];
}

//保存主题ID
- (void)saveThemeType:(NSInteger)type
{
    kUserDefaults
    [userDefaults setValue:[NSString stringWithFormat:@"%ld",type] forKey:@"themeType"];
    [userDefaults synchronize];
}

/**
 * 配置样式
 */
- (void)setupThemeStyle
{
    [self changeTabBarTintColor];
    [self changeNavBarBackgroundImage];
}

/**
 *  改变导航栏的背景色
 */
- (void)changeNavBarBackgroundImage
{
    UITabBarController *tabBarController = [GWTabBarManager shareTabBarManager].tabBarController;
    for (GWNavigationController *vigationController in tabBarController.viewControllers) {
        [vigationController setNavigationBarBackgroundImage];
    }
}

/**
 *  改变tabBar的tintColor
 */
- (void)changeTabBarTintColor
{
    UITabBarController *tabBarController = [GWTabBarManager shareTabBarManager].tabBarController;
    tabBarController.tabBar.tintColor = [[GWThemeManager shareThemeManager] themeTintColor];
}


@end
