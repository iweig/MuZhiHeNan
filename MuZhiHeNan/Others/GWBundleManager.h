//
//  GWBundleManager.h
//  MuZhiHeNan
//
//  Created by YK on 16/4/25.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWBundleManager : NSObject

+ (instancetype)shareBundleManager;

/**
 *  根据图片名字和bundle返回对应的UIImage对象
 *  @return <#return value description#>
 */
- (UIImage *)imageWithName:(NSString *)imageName bundleString:(NSString *)bundleString;

/**
 *  根据图片名字和bundle返回对应的UIImage对象
 *  @return <#return value description#>
 */
+ (UIImage *)imageWithName:(NSString *)imageName bundleString:(NSString *)bundleString;

@end
