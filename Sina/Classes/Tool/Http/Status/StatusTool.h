//
//  StatusTool.h
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//  微博数据层

#import <Foundation/Foundation.h>

@interface StatusTool : NSObject

/** 
 请求最新的微博数据
 
 sinceId 微博的字符串
 success 请求成功的回调(Status模型)
 failure 请求失败的回调
 */
+ (void)loadNewStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

/** 
 请求更多的微博数据
 
 maxId 微博的最大字符串
 success 请求成功的回调(Status模型)
 failure 请求失败的回调
 */
+ (void)loadMoreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *statuses))success failure:(void(^)(NSError *error))failure;

@end
