//
//  HttpManager.m
//  MuZhiHeNan
//
//  Created by gw on 16/5/1.
//  Copyright © 2016年 GW. All rights reserved.
//

#import "HttpManager.h"
#import "ProgressHUD.h"

@implementation HttpManager

static HttpManager *httpManager = nil;

+ (instancetype)shareHttpManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[HttpManager alloc] init];
    });
    return httpManager;
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 10.0;
    NSString *urlStr = kNSString(@"%@%@", kGlobalURL, URLString);
    [manager GET:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"Status"] integerValue]== 0) {
            [ProgressHUD show:@"请求数据出错！"];
            return;
        }
        if (success) {
            success(operation, responseObject[@"Info"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
    
}

+ (void)POST:(NSString *)URLString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer =[AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.requestSerializer.timeoutInterval = 10.0;
    NSString *urlStr = kNSString(@"%@%@", kGlobalURL, URLString);
    [manager POST:urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"Status"] integerValue]== 0) {
            [ProgressHUD show:@"请求数据出错！"];
            return;
        }
        if (success) {
            success(operation, responseObject[@"Info"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];

}



@end
