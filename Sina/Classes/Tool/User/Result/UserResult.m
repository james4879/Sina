//
//  UserResult.m
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "UserResult.h"

@implementation UserResult

/** 信息总和 */
- (int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

/** 未读信息总和 */
- (int)totalCount
{
    return self.messageCount + self.status + self.follower;
}

@end
