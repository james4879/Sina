//
//  StatusResult.h
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface StatusResult : NSObject <MJKeyValue>

/**
 *  用户的微博数组（CZStatus）
 */
@property (nonatomic, strong) NSArray *statuses;

/**
 *  用户最近微博总数
 */
@property (nonatomic, assign) int *total_number;

@end
