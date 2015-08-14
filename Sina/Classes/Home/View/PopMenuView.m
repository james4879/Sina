//
//  PopMenuView.m
//  Sina
//
//  Created by James on 3/6/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "PopMenuView.h"

@implementation PopMenuView

/** 显示 */
+ (instancetype)showInRect:(CGRect)rect
{
    PopMenuView *popMenu = [[PopMenuView alloc] initWithFrame:rect];
    popMenu.userInteractionEnabled = YES;
    popMenu.image = [UIImage imageWithStretchableName:@"popover_background"];
    [KeyWindow addSubview:popMenu];
    return popMenu;
}

/** 隐藏 */
+ (void)hide
{
    for (UIView *popView in KeyWindow.subviews) {
        if ([popView isKindOfClass:self]) {
            [popView removeFromSuperview];
        }
    }
}

/** 显示视图 */
- (void)setContentView:(UIView *)contentView
{
    [contentView removeFromSuperview];
    _contentView = contentView;
    contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:contentView];
}

/** 设置子控件的frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 5;
    CGFloat x = margin;
    CGFloat y = 9;
    CGFloat w = self.width - 2 * margin;
    CGFloat h = self.height - y - margin;
    self.contentView.frame = CGRectMake(x, y, w, h);
}

@end
