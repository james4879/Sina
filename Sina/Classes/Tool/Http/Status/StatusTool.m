//
//  StatusTool.m
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "StatusTool.h"
#import "MJExtension.h"
#import "StatusParameter.h"
#import "StatusResult.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "Status.h"
#import "StatusCacheTool.h"

@implementation StatusTool

/** 请求最新微博数据 */
+ (void)loadNewStatusWithSinceId:(NSString *)sinceId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    StatusParameter *param = [[StatusParameter alloc] init];
    param.access_token = [AccountTool account].access_token;
    if (sinceId) {// 有微博数据就下啦刷新
        param.since_id = sinceId;
    }
    
    // 进入程序先从数据库加载
    NSMutableArray *status = [StatusCacheTool statusWithParam:param];
    if (status.count) {
        if (success) {
            success(status);
        }
        return;
    }
    
    // 数据没有数据,创建GET请求
    [HttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        StatusResult *result = [StatusResult objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
        // 保存数据到数据库, 从服务器保存最原始的
        [StatusCacheTool saveStatus:responseObject[@"statuses"]];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/** 请求更多微博数据 */
+ (void)loadMoreStatusWithMaxId:(NSString *)maxId success:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure
{
    //创建参数模型
    StatusParameter *param = [[StatusParameter alloc] init];
    param.access_token = [AccountTool account].access_token;
    if (maxId) {
        param.max_id = maxId;
    }
    
    // 先加载数据库数据, 没有就向网络请求
    NSMutableArray *status = [StatusCacheTool statusWithParam:param];
    if (status.count) {
        if (success) {
            success(status);
        }
        return;
    }
    
    // 数据库木有数据,发送GET请求
    [HttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:param.keyValues success:^(id responseObject) {
        StatusResult *result = [StatusResult objectWithKeyValues:responseObject];
        if (success) {
            success(result.statuses);
        }
        // 有最新的数据就保存到数据库
        [StatusCacheTool saveStatus:responseObject[@"statuses"]];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
