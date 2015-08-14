//
//  ComposeTool.h
//  Sina
//
//  Created by James on 3/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComposeTool : NSObject

/**
 *  发送文字
 *
 *  @param status  发送微博内容
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)composeWithStatus:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;

/**
 *  发送图片
 *
 *  @param status   发送微博文字内容
 *  @param image    发送微博图片内容
 *  @param success  成功的回调
 *  @param failure  失败的回调
 */
+ (void)composeWithStatus:(NSString *)status image:(UIImage *)image success:(void(^)())success failure:(void(^)(NSError *error))failure;

@end
