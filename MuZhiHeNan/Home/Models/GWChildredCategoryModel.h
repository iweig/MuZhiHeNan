//
//  GWChildredCategoryModel.h
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "BaseModel.h"

@interface GWChildredCategoryModel : BaseModel

@property (nonatomic, copy, readonly) NSString *catId;
@property (nonatomic, copy, readonly) NSString *thumb;
@property (nonatomic, copy, readonly) NSString *catname;


+ (instancetype)childredCategoryModelWithDict:(NSDictionary *)dict;

@end
