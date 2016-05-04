//
//  GWSubjectModel.m
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "GWSubjectModel.h"
#import "GWNewsModel.h"

@implementation GWSubjectModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        _name = dict[@"name"];
        _catId = dict[@"cat_id"];
        NSMutableArray *lists = [NSMutableArray array];
        for (NSDictionary *modelDict in dict[@"lists"]) {
            GWNewsModel *newsModel = [GWNewsModel newsModelWithDict:modelDict];
            [lists addObject:newsModel];
        }
        _lists = lists;
    }
    return self;
}

+ (instancetype)subjectModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
