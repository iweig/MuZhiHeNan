//
//  GWNewsDetailModel.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/3.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "BaseModel.h"

@interface GWNewsDetailModel : BaseModel

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *inputtime;
@property (nonatomic, copy) NSString *support;
@property (nonatomic, copy) NSString *reporters;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *copyfrom;
@property (nonatomic, copy) NSString *voteid;
@property (nonatomic, copy) NSString *content_id;
@property (nonatomic, copy) NSString *catname;
@property (nonatomic, copy) NSString *cat_id;
@property (nonatomic, copy) NSString *editor;
@property (nonatomic, copy) NSString *form_url;
@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger allow_comment;
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) NSInteger is_favor;

@property (nonatomic, strong) NSMutableArray *zutu;

+ (instancetype)newsDetailModelWithDict:(NSDictionary *)dict;


@end
