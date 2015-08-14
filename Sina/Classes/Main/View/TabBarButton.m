//
//  TabBarButton.m
//  Sina
//
//  Created by James on 3/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#define kImageRidio 0.7

#import "TabBarButton.h"
#import "BadgeButton.h"

@interface TabBarButton ()

@property (nonatomic, strong) BadgeButton *badgeBtn;

@end

@implementation TabBarButton

- (BadgeButton *)badgeBtn
{
    if (!_badgeBtn) {
        BadgeButton *badgeBtn = [BadgeButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:badgeBtn];
        _badgeBtn = badgeBtn;
    }
    return _badgeBtn;
}

/** 重写UITabBarItem的setter方法,给属性赋值 */
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    //使用kvo监听值的改变
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
}

/** 属性的值发生改变的时候 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    self.badgeBtn.badgeValue = self.item.badgeValue;
}

/**  初始化控件  */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        //设置标题显示的颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        //设置图片的属性
        self.imageView.contentMode = UIViewContentModeCenter;
        //设置文字的属性
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

/** 调整子控件的frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //图片
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * kImageRidio;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    //文字
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = imageW;
    CGFloat titleH = self.frame.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    //badgeValue
    self.badgeBtn.x = self.width - self.badgeBtn.width - 10;
    self.badgeBtn.y = 0;
}

@end
