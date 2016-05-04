//
//  GWSubjectModel.h
//  MuZhiHeNan
//
//  Created by YK on 16/5/4.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "BaseModel.h"

@interface GWSubjectModel : BaseModel

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *catId;
@property (nonatomic, strong) NSArray *lists;

+ (instancetype)subjectModelWithDict:(NSDictionary *)dict;

@end
