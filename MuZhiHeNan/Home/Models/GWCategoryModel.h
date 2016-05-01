//
//  GWCategoryModel.h
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "BaseModel.h"

@interface GWCategoryModel : BaseModel

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *shortName;
@property (nonatomic, strong) NSArray *childrenArr;


+ (instancetype)categoryModelWithDict:(NSDictionary *)dict;

@end
