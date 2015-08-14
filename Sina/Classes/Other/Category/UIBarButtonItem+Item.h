//
//  UIBarButtonItem+Item.h
//  Sina
//
//  Created by James on 3/6/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Item)

/** 自定义导航栏按钮 */
+ (UIBarButtonItem *)barButtonItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
