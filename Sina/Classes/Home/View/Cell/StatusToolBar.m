//
//  StatusToolBar.m
//  Sina
//
//  Created by James on 3/12/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "StatusToolBar.h"
#import "Status.h"

@interface StatusToolBar ()

@property (nonatomic, strong) NSMutableArray *btns;

@property (nonatomic, strong) NSMutableArray *divideVs;

@property (nonatomic, weak) UIButton *retweet;

@property (nonatomic, weak) UIButton *comment;

@property (nonatomic, weak) UIButton *unlike;

@end

@implementation StatusToolBar

-(NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)divideVs
{
    if (!_divideVs) {
        _divideVs = [NSMutableArray array];
    }
    return _divideVs;
}

/** 初始化 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setUpAllChildView];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
    }
    return self;
}

/** 添加子控件 */
- (void)setUpAllChildView
{
    // 转发
    UIButton *retweet = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_retweet"]
                                                title:@"转发"];
    _retweet = retweet;
    
    // 评论
    UIButton *comment = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_comment"]
                                                title:@"评论"];
    _comment = comment;
    
    // 👍
    UIButton *unlike = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_unlike"]
                                               title:@"赞"];
    _unlike = unlike;
    
    // 分隔线
    for (NSInteger index = 0; index < 2; index++) {
        UIImageView *div = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:div];
        [self.divideVs addObject:div];
    }
}

/** 封装初始化toolBar按钮 */
- (UIButton *)setUpOneButtonWithImage:(UIImage *)image title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

/** 调整子控件frame */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.btns.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kScreenW / count;
    CGFloat h = self.height;
    for (NSInteger index = 0; index < count; index++) {
        UIButton *btn = self.btns[index];
        x = index * w;
        btn.frame = CGRectMake(x, y, w, h);
    }
    
    NSInteger index = 1;
    for (UIImageView *divView in self.divideVs) {
        UIButton *btn = self.btns[index];
        divView.x = btn.x;
        index++;
    }
}

/** 重写setter方法,给属性赋值 */
- (void)setStatus:(Status *)status
{
    _status = status;
    //设置转发的标题
    [self setBtn:_retweet title:status.reposts_count];
    // 评论标题
    [self setBtn:_comment title:status.comments_count];
    // 设置赞
    [self setBtn:_unlike title:status.attitudes_count];
}

/** 设置按钮的标题 */
- (void)setBtn:(UIButton *)btn title:(int)count
{
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        } else {
            title = [NSString stringWithFormat:@"%d", count];
        }
        // 设置转发
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end


