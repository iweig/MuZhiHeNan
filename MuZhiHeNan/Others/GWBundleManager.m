//
//  GWBundleManager.m
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWBundleManager.h"

@implementation GWBundleManager

static GWBundleManager *bundleManager;
+ (instancetype)shareBundleManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bundleManager = [[GWBundleManager alloc] init];
    });
    return bundleManager;
}

- (UIImage *)imageWithName:(NSString *)imageName bundleString:(NSString *)bundleString
{
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleString ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *imagePath = [bundle pathForResource:imageName ofType:@"png"];
    return [UIImage imageNamed:imagePath];
}

+ (UIImage *)imageWithName:(NSString *)imageName bundleString:(NSString *)bundleString
{
    return [[GWBundleManager shareBundleManager] imageWithName:imageName bundleString:bundleString];
}

@end
