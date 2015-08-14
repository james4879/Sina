//
//  BaseParameter.h
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseParameter : NSObject

/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;

/** 构造方法 */
+ (instancetype)paramter;

@end
