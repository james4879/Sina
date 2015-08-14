//
//  BaseParameter.m
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "BaseParameter.h"
#import "Account.h"
#import "AccountTool.h"

@implementation BaseParameter

/** 构造方法 */
+ (instancetype)paramter
{
    BaseParameter *parameter = [[self alloc] init];
    parameter.access_token = [AccountTool account].access_token;
    return parameter;
}

@end
