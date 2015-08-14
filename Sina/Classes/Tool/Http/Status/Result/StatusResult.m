//
//  StatusResult.m
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "StatusResult.h"
#import "Status.h"

@implementation StatusResult

/** 字典转模型 */
+ (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[Status class]};
}

@end
