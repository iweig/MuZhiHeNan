//
//  GWThemeManager.h
//  MuZhiHeNan
//
//  Created by gw on 16/4/21.
//  Copyright © 2016年 GW. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GWThemeManager : NSObject

- (void)intiCurrentTheme;

- (void)setTHemeType:(NSInteger)type;

- (UIImage *)imageWithNameString:(NSString *)imageStr;

@end
