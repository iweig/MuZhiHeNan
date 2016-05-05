//
//  GWSearchInfoModel.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/5.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSearchInfoModel.h"

@implementation GWSearchInfoModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    return [GWSearchInfoModel mj_objectWithKeyValues:dict];
}

+ (instancetype)searchInfoModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
