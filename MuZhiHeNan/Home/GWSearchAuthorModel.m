//
//  GWSearchAuthorModel.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/5.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSearchAuthorModel.h"

@implementation GWSearchAuthorModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    return [GWSearchAuthorModel mj_objectWithKeyValues:dict];
}

+ (instancetype)searchAuthorModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
