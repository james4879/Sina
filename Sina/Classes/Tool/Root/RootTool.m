//
//  RootTool.m
//  Sina
//
//  Created by James on 3/9/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "RootTool.h"
#import "NewFeatureViewController.h"
#import "TabBarViewController.h"

#define kVersionKey @"version"

@implementation RootTool

/** 选择根控制器 */
+ (void)chooseRootViewController:(UIWindow *)window
{
    // 当前版本
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    // 之前版本
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:kVersionKey];
    if ([currentVersion isEqualToString:lastVersion]) {
        TabBarViewController *tabBarVc = [[TabBarViewController alloc] init];
        window.rootViewController = tabBarVc;
    } else {
        NewFeatureViewController *newVc = [[NewFeatureViewController alloc] init];
        window.rootViewController = newVc;
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:kVersionKey];
    }
}

@end
