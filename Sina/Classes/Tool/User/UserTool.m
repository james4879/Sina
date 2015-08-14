//
//  UserTool.m
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "UserTool.h"
#import "UserParameter.h"
#import "UserResult.h"
#import "HttpTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "MJExtension.h"
#import "User.h"

@implementation UserTool

/** 请求微博的未读信息
    success 请求成功的回调
    failure 请求失败的回调
 */
+ (void)unReadWithSuccess:(void (^)(UserResult *))success failure:(void (^)(NSError *))failure{
    // 创建数据模型
    UserParameter *param = [UserParameter paramter];
    param.uid = [AccountTool account].uid;
    //创建GET请求
    [HttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:param.keyValues success:^(id responseObject) {
        // 字典转模型
        UserResult *result = [UserResult objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/** 请求用户的信息 */
+ (void)userInfoWithSuccess:(void (^)(User *))success failure:(void (^)(NSError *))failure
{
    // 数据模型
    UserParameter *param = [UserParameter paramter];
    param.uid = [AccountTool account].uid;
    // 字典转模型
    [HttpTool GET:@"https://api.weibo.com/2/users/show.json" parameters:param.keyValues success:^(id responseObject) {
        User *user = [User objectWithKeyValues:responseObject];
        if (success) {
            success(user);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
