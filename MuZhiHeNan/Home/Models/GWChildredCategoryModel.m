//
//  GWChildredCategoryModel.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWChildredCategoryModel.h"

@implementation GWChildredCategoryModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        _catId = dict[@"cat_id"];
        _thumb = dict[@"thumb"];
        _catname = dict[@"catname"];
    }
    return self;
}

+ (instancetype)childredCategoryModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
