//
//  Account.h
//  Sina
//
//  Created by James on 3/9/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject <NSCoding>

/** 数据访问令牌 */
@property (nonatomic, copy) NSString *access_token;

/** 账号有效期 */
@property (nonatomic, copy) NSString *expires_in;

/** 用户唯一标示 */
@property (nonatomic, copy) NSString *uid;

/** 过期时间 = 保存时间 + 有效期 */
@property (nonatomic, strong) NSDate *expires_date;

/** 账号有效期 */
@property (nonatomic, copy) NSString *remind_in;

/** 用户昵称 */
@property (nonatomic, copy) NSString *name;

/** 构造方法 */
+ (instancetype)accountWithDic:(NSDictionary *)dic;

@end
