//
//  UserParameter.h
//  Sina
//
//  Created by James on 3/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "BaseParameter.h"
#import "BaseParameter.h"

@interface UserParameter : BaseParameter

/**
 *  当前登录用户唯一标识符
 */
@property (nonatomic, copy) NSString *uid;

@end
