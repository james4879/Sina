//
//  ComposePhotoView.m
//  Sina
//
//  Created by James on 3/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "ComposePhotoView.h"

@implementation ComposePhotoView

/** 重写setter方法 */
- (void)setImage:(UIImage *)image
{
    _image = image;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    [self addSubview:imageView];
}

/** 设置子控件的frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger cols = 3;
    CGFloat margin = 10;
    CGFloat wh = (self.width - (cols - 1) * margin) / cols;
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger col = 0;
    NSInteger row = 0;
    for (NSInteger index = 0; index < self.subviews.count; index++) {
        UIImageView *imageView = self.subviews[index];
        col = index * cols;
        row = index / cols;
        x = col * (margin + wh);
        y = row * (margin + wh);
        imageView.frame = CGRectMake(x, y, wh, wh);
    }
}

@end
