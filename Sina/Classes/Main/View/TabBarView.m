//
//  TabBarView.m
//  Sina
//
//  Created by James on 3/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "TabBarView.h"
#import "TabBarButton.h"

@interface TabBarView ()

@property (nonatomic, strong) UIButton *plusBtn;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation TabBarView

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIButton *)plusBtn
{
    if (!_plusBtn) {
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateHighlighted];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [plusBtn sizeToFit];
        _plusBtn = plusBtn;
        [self addSubview:_plusBtn];
    }
    return _plusBtn;
}

/** 加号按钮点击事件 */
- (void)plusClick
{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

/** 重写setitem方法,给属性赋值 */
- (void)setItems:(NSMutableArray *)items
{
    _items = items;
    
    for (UITabBarItem *item in _items) {
        TabBarButton *tabBarBtn = [TabBarButton buttonWithType:UIButtonTypeCustom];
        tabBarBtn.item = item;
        tabBarBtn.tag = self.buttons.count;
        [tabBarBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
        if (tabBarBtn.tag == 0) {
            [self btnClick:tabBarBtn];
        }
        [self addSubview:tabBarBtn];
        [self.buttons addObject:tabBarBtn];
    }
}

/** 点击tabbar */
- (void)btnClick:(UIButton *)btn
{
    //三部曲
    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
    if ([self.delegate respondsToSelector:@selector(tabBar:didClickAtIndex:)]) {
        [self.delegate tabBar:self didClickAtIndex:btn.tag];
    }
}

/** 调整子控件的位置 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //tabbar的尺寸
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    //tabBarItem尺寸
    CGFloat btnW = w / (self.items.count + 1);
    CGFloat btnH = h;
    CGFloat btnX = 0;
    CGFloat btnY = btnX;
    NSInteger index = 0;
    for (UIView *tabBarBtn in self.buttons) {
        if (index == 2) {
            index = 3;
        }
        btnX = index * btnW;
        tabBarBtn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        index++;
    }
    self.plusBtn.center = CGPointMake(w * 0.5, h * 0.5);
}

@end
