//
//  CoverView.m
//  Sina
//
//  Created by James on 3/6/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

/** 显示 */
+ (instancetype)show
{
    CoverView *coverView = [[CoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    coverView.backgroundColor = [UIColor clearColor];
    [KeyWindow addSubview:coverView];
    return coverView;
}

/** 设置显示 */
- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    
    if (dimBackground) {
        [self setBackgroundColor:[UIColor blackColor]];
        self.alpha = 0.5;
    } else {
        [self setBackgroundColor:[UIColor clearColor]];
        self.alpha = 1;
    }
}

/** 点击隐藏 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(coverViewDidCover:)]) {
        [self.delegate coverViewDidCover:self];
    }
}

@end
