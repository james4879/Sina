//
//  User.m
//  Sina
//
//  Created by James on 3/10/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "User.h"

@implementation User

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
