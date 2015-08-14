//
//  PopMenuView.h
//  Sina
//
//  Created by James on 3/6/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopMenuView : UIImageView

/** 显示菜单 */
+ (instancetype)showInRect:(CGRect)rect;

/** 隐藏菜单 */
+ (void)hide;

/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;

@end
