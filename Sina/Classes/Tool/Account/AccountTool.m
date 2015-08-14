//
//  AccountTool.m
//  Sina
//
//  Created by James on 3/9/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "AccountTool.h"
#import "Account.h"
#import "AccountParam.h"
#import "HttpTool.h"
#import "MJExtension.h"

#define kAuthorizeBaseUrl  @"https://api.weibo.com/oauth2/authorize"
#define kClient_id         @"263066535"
#define kRedirect_uri      @"http://www.baidu.com"
#define kClient_secret     @"892905423983299c687089d9ff2f879b"

#define kAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation AccountTool

/** 类方法使用静态变量代替成员变量 */
static Account *_account;

/** 归档 */
+ (void)saveAccount:(Account *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountFileName];
}

/** 解档 */
+ (Account *)account
{
    if (!_account) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountFileName];
        // 判断账号是否过期
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    return _account;
}

/** 获取用户账号信息 */
+ (void)accountWithCode:(NSString *)code success:(void (^)())success failure:(void (^)(NSError *))failure
{
    //创建账号参数模型
    AccountParam *param = [[AccountParam alloc] init];
    param.client_id = kClient_id;
    param.client_secret = kClient_secret;
    param.grant_type = @"authorization_code";
    param.code = code;
    param.redirect_uri = kRedirect_uri;
    //创建post请求
    [HttpTool POST:@"https://api.weibo.com/oauth2/access_token" parameters:param.keyValues success:^(id responseObject) {
        //字典转模型
        Account *account = [Account accountWithDic:responseObject];
        //保存账号信息
        [AccountTool saveAccount:account];
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
