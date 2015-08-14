//
//  AccountTool.h
//  Sina
//
//  Created by James on 3/9/15.
//  Copyright (c) 2015 James. All rights reserved.
//  账号业务

#import <Foundation/Foundation.h>

@class Account;

@interface AccountTool : NSObject

/** 归档 */
+ (void)saveAccount:(Account *)account;

/** 解档 */
+ (Account *)account;

/** 获取用户账号信息 */
+ (void)accountWithCode:(NSString *)code success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
