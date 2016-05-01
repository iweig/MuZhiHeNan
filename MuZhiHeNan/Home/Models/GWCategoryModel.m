//
//  GWCategoryModel.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWCategoryModel.h"
#import "GWChildredCategoryModel.h"

@interface GWCategoryModel ()


@end

@implementation GWCategoryModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _name = dict[@"name"];
        _shortName = dict[@"short_name"];
        NSMutableArray *modelArr = [NSMutableArray array];
        for (NSDictionary *modelDict in dict[@"children"]) {
            GWChildredCategoryModel *model = [GWChildredCategoryModel childredCategoryModelWithDict:modelDict];
            [modelArr addObject:model];
        }
        _childrenArr = modelArr;
        
    }
    return self;
}

+ (instancetype)categoryModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
