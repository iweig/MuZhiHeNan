//
//  GWAdesModel.h
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "BaseModel.h"

@interface GWNewsModel : BaseModel

@property (nonatomic, assign) NSInteger is_link;
@property (nonatomic, assign) NSInteger views;
@property (nonatomic, assign) NSInteger internal_id;
@property (nonatomic, assign) NSInteger comment;

@property (nonatomic, copy) NSString *link_url;
@property (nonatomic, copy) NSString *catname;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cotent_id;
@property (nonatomic, copy) NSString *internal_type;
@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *content_type;
@property (nonatomic, copy) NSString *brief;

+ (instancetype)newsModelWithDict:(NSDictionary *)dict;

@end
