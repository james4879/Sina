//
//  PhotoView.m
//  Sina
//
//  Created by James on 3/15/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "PhotoView.h"
#import "UIImageView+WebCache.h"
#import "Photo.h"

@interface PhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation PhotoView

/**  初始化控件  */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        // 设置图片显示的模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif" ]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

/** 重写setter方法,给属性赋值 */
- (void)setPhoto:(Photo *)photo
{
    _photo = photo;
    
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    } else {
        self.gifView.hidden = YES;
    }
}

/** 调整子控件frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
