//
//  GWSearchAuthorModel.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/5.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "BaseModel.h"

@interface GWSearchAuthorModel : BaseModel

@property (nonatomic, copy) NSString *author_id;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *avatar;

+ (instancetype)searchAuthorModelWithDict:(NSDictionary *)dict;

@end
