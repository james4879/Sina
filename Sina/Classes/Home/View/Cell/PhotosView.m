//
//  PhotosView.m
//  Sina
//
//  Created by James on 3/14/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "PhotosView.h"
#import "Photo.h"
#import "UIImageView+WebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PhotoView.h"

@implementation PhotosView

/**  初始化控件  */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        // 添加9个子控件
        [self setUpAllChildView];
    }
    return self;
}

/** 添加9个子控件 */
- (void)setUpAllChildView
{
    for (NSInteger index = 0; index < 9; index++) {
        PhotoView *imageView = [[PhotoView alloc] init];
        imageView.tag = index;
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
}

/** 添加图片手势点击 */
- (void)tap:(UITapGestureRecognizer *)tap
{
    UIImageView *tapView = tap.view;
    int index = 0;
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (Photo *photo in _pic_urls) {
        
        MJPhoto *p = [[MJPhoto alloc] init];
        // 设置高清图
        NSString *urlStr = photo.thumbnail_pic.absoluteString;
        urlStr = [urlStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        // URL
        p.url = [NSURL URLWithString:urlStr];
        // 下标
        p.index = index;
        // 图片资源
        p.srcImageView = tapView;
        [tmpArray addObject:p];
        index++;
    }
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    // 下标
    browser.currentPhotoIndex = tapView.tag;
    // 图片数组
    browser.photos = tmpArray;
    [browser show];
}

/** 重写setter方法, 给属性赋值 */
- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    NSInteger count = self.subviews.count;
    for (NSInteger index = 0; index < count; index++) {
        
        PhotoView *imageView = self.subviews[index];
        if (index < _pic_urls.count) {
            imageView.hidden = NO;
            //获取模型
            Photo *photo = self.pic_urls[index];
            imageView.photo = photo;
        } else {
            imageView.hidden = YES;
        }
    }
}

/** 设置子控件的frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    NSInteger col = 0;
    NSInteger row = 0;
    int cols = self.pic_urls.count == 4 ? 2 : 3;
    
    for (NSInteger index = 0; index < self.pic_urls.count; index++) {
        col = index % cols;
        row = index / cols;
        UIImageView *imageView = self.subviews[index];
        x = col * (w + margin);
        y = row * (h + margin);
        imageView.frame = CGRectMake(x, y, w, h);
    }
}

@end
