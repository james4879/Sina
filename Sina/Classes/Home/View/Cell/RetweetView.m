//
//  RetweetView.m
//  Sina
//
//  Created by James on 3/12/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "RetweetView.h"
#import "Status.h"
#import "StatusFrame.h"
#import "PhotosView.h"

@interface RetweetView ()

//名称
@property (nonatomic, strong) UILabel *nameView;

/** 正文 */
@property (nonatomic, strong) UILabel *textView;

// 配图
@property (nonatomic, strong) PhotosView *photosView;

@end

@implementation RetweetView

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setUpAllchildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

/** 添加子控件 */
- (void)setUpAllchildView
{
    //名称
    UILabel *nameView = [[UILabel alloc] init];
    nameView.font = kNameFont;
    [self addSubview:nameView];
    self.nameView = nameView;
    //正文
    UILabel *textView = [[UILabel alloc] init];
    textView.font = kTextFont;
    textView.numberOfLines = 0;
    [self addSubview:textView];
    self.textView = textView;
    // 配图
    PhotosView *photosView = [[PhotosView alloc] init];
    [self addSubview:photosView];
    self.photosView = photosView;
}

/** 重写setter方法,给属性赋值 */
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    Status *status = statusFrame.status;
    //昵称
    self.nameView.frame = statusFrame.retweetNameFrame;
    self.nameView.text = status.retweetName;
    //正文
    self.textView.frame = statusFrame.retweetTextFrame;
    self.textView.text = status.retweeted_status.text;
    // 配图
    self.photosView.frame = statusFrame.retweetPhotosFrame;
    self.photosView.pic_urls = status.retweeted_status.pic_urls;
}

@end
