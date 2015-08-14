//
//  StatusCacheTool.h
//  Sina
//
//  Created by James on 3/17/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StatusParameter;

@interface StatusCacheTool : NSObject

/** 模型数组 */
+ (void)saveStatus:(NSMutableArray *)status;

/** 模型参数 */
+ (NSMutableArray *)statusWithParam:(StatusParameter *)param;

@end
