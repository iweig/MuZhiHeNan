//
//  GWExpandModel.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/2.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "BaseModel.h"

@interface GWExpandModel : BaseModel

@property (nonatomic, copy) NSString *special_id;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content_type;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *views;

@property (nonatomic, assign) NSInteger comment;

+ (instancetype)expandModelWithDict:(NSDictionary *)dict;

@end
