//
//  Account.m
//  Sina
//
//  Created by James on 3/9/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "Account.h"

#define kAccountTokenKey   @"access_token"
#define kExpires_inKey     @"expires_in"
#define kExpires_dateKey   @"expires_date"
#define kUidKey            @"uid"

@implementation Account

/** 构造方法 */
+ (instancetype)accountWithDic:(NSDictionary *)dic
{
    Account *account = [[Account alloc] init];
    [account setValuesForKeysWithDictionary:dic];
    return account;
}

/** 设置有效期 */
- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    //设置时间 = 当前事件 + 有效期
    self.expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}

/** 归档 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:kAccountTokenKey];
    [aCoder encodeObject:self.expires_in forKey:kExpires_inKey];
    [aCoder encodeObject:self.expires_date forKey:kExpires_dateKey];
    [aCoder encodeObject:self.uid forKey:kUidKey];
}

/** 解档 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:kAccountTokenKey];
        self.expires_in = [aDecoder decodeObjectForKey:kExpires_inKey];
        self.expires_date = [aDecoder decodeObjectForKey:kExpires_dateKey];
        self.uid = [aDecoder decodeObjectForKey:kUidKey];
    }
    return self;
}

@end
