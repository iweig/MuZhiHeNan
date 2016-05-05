//
//  NetworkConf.h
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#ifndef NetworkConf_h
#define NetworkConf_h

#import "HttpManager.h"

#define kGlobalURL @"http://api.henandaily.cn"
#define kGetAllCategory @"/v1/content/getallcategory"
#define kGetAllNews @"/v1/content/getallnews1"

#define kUserId @"0"
#define kToken @"8de8af6f01e8a9b8b2a649a9"
#define kGetReDianData @"/v9/content/getposition"

#define kGetCategoryList @"/v1/content/GetCategoryList"

#define kGetSpecialContent @"/v1/content/getSpecialContent"

#define kGetsearchhotwords @"/v1/content/getsearchhotwords"
//新闻详情
#define kGetNewsDetail @"/v1/content/getnewsbyid"

//收藏
#define kAddfavourite @"/v1/content/addfavourite"

//点赞
#define kDianzan @"/v1/content/support"

#define kSearch @"/v1/content/search1"

#endif /* NetworkConf_h */
