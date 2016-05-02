//
//  GWAdesModel.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsModel.h"

@implementation GWNewsModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    return [GWNewsModel mj_objectWithKeyValues:dict];
}

+ (instancetype)adesModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
