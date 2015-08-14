//
//  TextView.m
//  Sina
//
//  Created by James on 3/14/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "TextView.h"

@interface TextView ()

@property (nonatomic, weak) UILabel *placeHolderLabel;

@end

@implementation TextView

/**  初始化控件  */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (UILabel *)placeHolderLabel
{
    if (!_placeHolderLabel) {
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        [self addSubview:placeHolderLabel];
        self.placeHolderLabel = placeHolderLabel;
    }
    return _placeHolderLabel;
}

/** 调整子控件的frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}

/************** 重写setter方法,给属性赋值 ***************/
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    self.placeHolderLabel.text = placeHolder;
    // 设置尺寸一样
    [self.placeHolderLabel sizeToFit];
}

- (void)setHidePlaceHolder:(BOOL)hidePlaceHolder
{
    _hidePlaceHolder = hidePlaceHolder;
    self.placeHolderLabel.hidden = hidePlaceHolder;
}

/** 重写setfont方法 */
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeHolderLabel.font = font;
    [self.placeHolderLabel sizeToFit];
}

@end
