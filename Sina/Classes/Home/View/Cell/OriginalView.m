//
//  OriginalView.m
//  Sina
//
//  Created by James on 3/12/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "OriginalView.h"
#import "Status.h"
#import "StatusFrame.h"
#import "UIImageView+WebCache.h"
#import "PhotosView.h"

@interface OriginalView ()

// 头像
@property (nonatomic, weak) UIImageView *iconView;

// 昵称
@property (nonatomic, weak) UILabel *nameView;

// vip
@property (nonatomic, weak) UIImageView *vipView;

// 时间
@property (nonatomic, weak) UILabel *timeView;

// 来源
@property (nonatomic, weak) UILabel *sourceView;

// 正文
@property (nonatomic, weak) UILabel *textView;

// 配图
@property (nonatomic, strong) PhotosView *photosView;

@end

@implementation OriginalView

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
    }
    return self;
}

/** 添加子控件 */
- (void)setUpAllChildView
{
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    // 昵称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = kNameFont;
    [self addSubview:nameView];
    self.nameView = nameView;
    
    // vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    self.vipView = vipView;
    
    //时间
    UILabel *timeView = [[UILabel alloc] init];
    timeView.font = kTimeFont;
    timeView.textColor = [UIColor orangeColor];
    [self addSubview:timeView];
    self.timeView = timeView;
    
    // 来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = kSourceFont;
    [self addSubview:sourceView];
    self.sourceView = sourceView;
    
    // 正文
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = kTextFont;
    textLabel.numberOfLines = 0;
    [self addSubview:textLabel];
    self.textView = textLabel;
    
    // 配图
    PhotosView *photoView = [[PhotosView alloc] init];
    [self addSubview:photoView];
    self.photosView = photoView;
}

/** 重写status的setter方法 */
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //设置frame
    [self setUpFrame];
    //设置data
    [self setUpData];
}

/** 设置Data */
- (void)setUpData
{
    Status *status = self.statusFrame.status;
    // 头像
    [self.iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 昵称
    if (status.user.vip) {
        self.nameView.textColor = [UIColor redColor];
    } else {
        self.nameView.textColor = [UIColor blackColor];
    }
    self.nameView.text = status.user.name;
    //vip
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank];
    UIImage *image = [UIImage imageNamed:imageName];
    self.vipView.image = image;
    //时间
    self.timeView.text = status.created_at;
    //来源
    self.sourceView.text = status.source;
    //正文
    self.textView.text = status.text;
    // 配图
    self.photosView.pic_urls = status.pic_urls;
}

/** 设置frame */
- (void)setUpFrame
{
    // 头像
    self.iconView.frame = self.statusFrame.originalIconFrame;
    //昵称
    self.nameView.frame = self.statusFrame.originalNameFrame;
    //vip
    if (self.statusFrame.status.user.vip) {
        self.vipView.hidden = NO;
        self.vipView.frame = self.statusFrame.originalVipFrame;
    } else {
        self.vipView.hidden = YES;
    }
    //时间
    Status *status = self.statusFrame.status;
    CGFloat timeX = self.nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.nameView.frame) + kStatusCellMargin * 0.5;
    CGSize timeSize = [status.created_at sizeWithAttributes:@{NSFontAttributeName:kTimeFont}];
    self.timeView.frame = (CGRect){{timeX, timeY}, timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeView.frame) + kStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithAttributes:@{NSFontAttributeName:kSourceFont}];
    self.sourceView.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    //正文
    self.textView.frame = self.statusFrame.originalTextFrame;
    // 配图
    self.photosView.frame = self.statusFrame.originalPhotoFrame;
}

@end
