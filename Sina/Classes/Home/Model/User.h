//
//  User.h
//  Sina
//
//  Created by James on 3/10/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;

/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;

/** 是否是vip */
@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
