

//
//  GWExpandModel.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWExpandModel.h"

@implementation GWExpandModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    return [GWExpandModel mj_objectWithKeyValues:dict];
}

+ (instancetype)expandModelWithDict:(NSDictionary *)dict
{
    return [[self alloc ] initWithDict:dict];
}

@end
