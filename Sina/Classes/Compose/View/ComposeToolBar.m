//
//  ComposeToolBar.m
//  Sina
//
//  Created by James on 3/14/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "ComposeToolBar.h"

@implementation ComposeToolBar

/**  初始化控件  */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        // 添加子控件
        [self setUpAllChildView];
    }
    return self;
}

/** 添加子控件 */
- (void)setUpAllChildView
{
    // 相册
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_toolbar_picture"]
                     highImage:[UIImage imageNamed:@"compose_toolbar_picture_highlighted"]
                        target:self
                        action:@selector(btnClick:)];
    // 提及
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_mentionbutton_background"]
                     highImage:[UIImage imageNamed:@"compose_mentionbutton_background_highlighted"]
                        target:self
                        action:@selector(btnClick:)];
    // 话题
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_trendbutton_background"]
                      highImage:[UIImage imageNamed:@"compose_trendbutton_background_highlighted"]
                         target:self
                         action:@selector(btnClick:)];
    // 表听
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_emoticonbutton_background"]
                       highImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"]
                          target:self
                          action:@selector(btnClick:)];
    // 键盘
    [self setUpButtonWithImage:[UIImage imageNamed:@"compose_keyboardbutton_background"]
                        highImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"]
                           target:self
                           action:@selector(btnClick:)];
}

- (void)btnClick:(UIButton *)btn
{
    NSLog(@"%s", __func__);
    if ([self.delegate respondsToSelector:@selector(composeToolBar:didClickBtnAtIndex:)]) {
        [self.delegate composeToolBar:self didClickBtnAtIndex:btn.tag];
    }
}

/** 初始化按钮 */
- (void)setUpButtonWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = self.subviews.count;
    [self addSubview:btn];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

/** 调整子控件的frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.width / count;
    CGFloat h = self.height;
    for (NSUInteger index = 0; index < count; index++) {
        UIButton *btn = self.subviews[index];
        x = index * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
}

@end
