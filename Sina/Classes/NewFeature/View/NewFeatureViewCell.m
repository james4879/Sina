//
//  NewFeatureViewCell.m
//  Sina
//
//  Created by James on 3/8/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "NewFeatureViewCell.h"
#import "TabBarViewController.h"

@interface NewFeatureViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, strong) UIButton *startButton;

@end

@implementation NewFeatureViewCell

/** 重写setter方法,给属性赋值 */
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

/** 判断是否是最后一页 */
- (void)setIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count
{
    if (indexPath.row == count - 1) {
        self.shareButton.hidden = NO;
        self.startButton.hidden = NO;
    } else {
        self.shareButton.hidden = YES;
        self.startButton.hidden = YES;
    }
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}

- (UIButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [_shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [_shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_shareButton sizeToFit];
        [_shareButton addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_shareButton];
    }
    return _shareButton;
}

- (void)btn:(UIButton *)btn
{
    btn.selected = !btn.selected;
}

- (UIButton *)startButton
{
    if (!_startButton) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_startButton];
        [_startButton setTitle:@"开始微博" forState:UIControlStateNormal];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [_startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [_startButton sizeToFit];
        [_startButton addTarget:self action:@selector(startBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (void)startBtn:(UIButton *)btn
{
    TabBarViewController *tabBarVc = [[TabBarViewController alloc] init];
    KeyWindow.rootViewController = tabBarVc;
}

/** 调整子控件的frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.shareButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.8);
    self.startButton.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.9);
}

@end
