//
//  Status.m
//  Sina
//
//  Created by James on 3/10/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "Status.h"
#import "Photo.h"
#import "NSDate+MJ.h"

@implementation Status

+ (NSArray *)ignoredPropertyNames
{
    return @[@"retweetName"];
}

/** 字典转模型 */
+ (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[Photo class]};
}

/** 微博的创建时间 */
- (NSString *)created_at
{
    _created_at = @"Tue Mar 11 17:48:24 +0800 2015";
    
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    dataFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"EN_US"];
    NSDate *create_at = [dataFormatter dateFromString:_created_at];
    
    if ([create_at isThisYear]) {// 今年
        if ([create_at isToday]) {// 今天
            //计算当前时间的差距
            NSDateComponents *cmp = [create_at deltaWithNow];
            NSLog(@"%ld-->%ld-->%ld", cmp.hour, cmp.minute, cmp.second);
            if (cmp.hour >= 1) {// 时
                return [NSString stringWithFormat:@"%ld小时之前", cmp.hour];
            } else if (cmp.minute > 1) {// 分
                return [NSString stringWithFormat:@"%ld分钟之前", cmp.minute];
            } else if (cmp.second > 1) {// 秒
                return [NSString stringWithFormat:@"%ld秒之前", cmp.second];
            } else {
                return @"刚刚";
            }
        } else if ([create_at isYesterday]) {
            dataFormatter.dateFormat = @"昨天 HH:mm";// 昨天
            return [dataFormatter stringFromDate:create_at];
        } else {
            dataFormatter.dateFormat =@"MM-dd HH:mm";// 前天
            return [dataFormatter stringFromDate:create_at];
        }
    } else {// 不是今年
        dataFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [dataFormatter stringFromDate:create_at];
    }
    
    return _created_at;
}

/** 来源 */
- (void)setSource:(NSString *)source
{
    /** 
     <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
     */
    // 字符串截取
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自 %@", source];
    _source = source;
}

- (void)setRetweeted_status:(Status *)retweeted_status
{
    _retweeted_status = retweeted_status;
    _retweetName = [NSString stringWithFormat:@"%@", retweeted_status.user.name];
}

@end
