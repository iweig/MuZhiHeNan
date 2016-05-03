//
//  GWNewsDetailModel.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/3.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWNewsDetailModel.h"

@implementation GWNewsDetailModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    [GWNewsDetailModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                  @"desc":@"desciption"
                 };
    }];
    return [GWNewsDetailModel mj_objectWithKeyValues:dict];
}

+ (instancetype)newsDetailModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


@end
