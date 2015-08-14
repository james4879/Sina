//
//  BadgeButton.m
//  Sina
//
//  Created by James on 3/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#define kBadgeFont [UIFont systemFontOfSize:11]

#import "BadgeButton.h"

@implementation BadgeButton

/**  初始化控件  */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        [self setImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = kBadgeFont;
        [self sizeToFit];
    }
    return self;
}

/** 重写sett方法,给属性赋值 */
- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) {
        self.hidden = YES;
    } else {
        self.hidden = NO;
    }
    
    CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName:kBadgeFont}];
//    NSLog(@"-->%f--->%f", size.width, self.width);
    if (size.width > self.width) {
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"new_dot"] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"main_badge"] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

@end
