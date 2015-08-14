//
//  UserTool.h
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserResult, User;

@interface UserTool : NSObject

/** 用户请求未读的信息数 */
+ (void)unReadWithSuccess:(void(^)(UserResult *result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 请求成功的回调
 *  @param failure 请求失败的回调
 */
+ (void)userInfoWithSuccess:(void(^)(User *user))success failure:(void(^)(NSError *error))failure;

@end
