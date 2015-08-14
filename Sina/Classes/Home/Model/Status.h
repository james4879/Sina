//
//  Status.h
//  Sina
//
//  Created by James on 3/10/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "User.h"

@interface Status : NSObject <MJKeyValue>

/**
 *  转发微博
 */
@property (nonatomic, strong) Status *retweeted_status;

/** 转发微博昵称 */
@property (nonatomic, copy) NSString *retweetName;

/**
 *  用户
 */
@property (nonatomic, strong) User *user;

/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;

/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;

/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;

/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;

/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;

/**
 *  表态数(赞)
 */
@property (nonatomic, assign) int attitudes_count;

/**
 *  配图数组(CZPhoto)
 */
@property (nonatomic, strong) NSArray *pic_urls;


@end
