//
//  UserResult.h
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserResult : NSObject

/**
 *  新微博未读数
 */
@property (nonatomic, assign) int status;

/**
 *  新粉丝数
 */
@property (nonatomic, assign) int follower;

/**
 *  新评论数
 */
@property (nonatomic, assign) int cmt;

/**
 *  新私信数
 */
@property (nonatomic, assign) int dm;

/**
 *  新提及我的微博数
 */
@property (nonatomic, assign) int mention_status;

/**
 *  新提及我的评论数
 */
@property (nonatomic, assign) int mention_cmt;

/** 信息总和 */
- (int)messageCount;

/** 未读信息总和 */
- (int)totalCount;

@end
