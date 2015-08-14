//
//  StatusViewCell.m
//  Sina
//
//  Created by James on 3/12/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "StatusViewCell.h"
#import "Status.h"
#import "OriginalView.h"
#import "RetweetView.h"
#import "StatusToolBar.h"
#import "StatusFrame.h"

@interface StatusViewCell ()

@property (nonatomic, weak) OriginalView *originalView;

@property (nonatomic, weak) RetweetView *retweetView;

@property (nonatomic, weak) StatusToolBar *toolBar;

@end

@implementation StatusViewCell

/** cell的重用 */
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    id cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

/** cell的初始化 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //添加子控件
        [self setUpAllChildView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/** 添加子控件 */
- (void)setUpAllChildView
{
    //原创
    OriginalView *originalView = [[OriginalView alloc] init];
    [self addSubview:originalView];
    self.originalView = originalView;
    
    //转发
    RetweetView *retweet = [[RetweetView alloc] init];
    [self addSubview:retweet];
    self.retweetView = retweet;
    
    //工具栏
    StatusToolBar *toolBar = [[StatusToolBar alloc] init];
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

/** 重写statusFrame的setter方法.给属性赋值 */
- (void)setStatusFrame:(StatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    //设置原创微博的frame
    self.originalView.frame = statusFrame.originalViewFrame;
    self.originalView.statusFrame = statusFrame;
    
    // 设置转发微博的frame
    if (statusFrame.status.retweeted_status) {
        self.retweetView.frame = statusFrame.retweetViewFrame;
        self.retweetView.statusFrame = statusFrame;
        self.retweetView.hidden = NO;
    } else {
        self.retweetView.hidden = YES;
    }
    
    // 工具条frame
    self.toolBar.frame = statusFrame.tooBarFrame;
    self.toolBar.status = statusFrame.status;
}

@end
