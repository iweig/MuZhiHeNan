//
//  GWThemeManager.m
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWThemeManager.h"

@interface GWThemeManager ()

//当前的主题包
@property (nonatomic, strong) NSString *themeBundle;

//主题包数组
@property (nonatomic, strong) NSArray *themeArr;

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

static GWThemeManager *themeManager;

+ (instancetype)GWThemeManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        themeManager = [[GWThemeManager alloc] init];
    });
    return themeManager;
}

/**
 *  初始化主题
 */
- (void)intiCurrentTheme
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


@end
