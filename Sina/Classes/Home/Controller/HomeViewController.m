//
//  HomeViewController.m
//  Sina
//
//  Created by James on 3/6/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "HomeViewController.h"
#import "TitleButton.h"
#import "PopMenuView.h"
#import "CoverView.h"
#import "PopViewController.h"
#import "OneViewController.h"
#import "MJRefresh.h"
#import "HttpTool.h"
#import "Status.h"
#import "User.h"
#import "AccountTool.h"
#import "Account.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "StatusTool.h"
#import "UserTool.h"
#import "StatusViewCell.h"
#import "StatusFrame.h"

@interface HomeViewController () <CoverViewDelegate>

@property (nonatomic, strong) TitleButton *titleBtn;

@property (nonatomic, strong) PopViewController *popViewController;

/** 封装weibo的frame */
@property (nonatomic, strong) NSMutableArray *statusesFrame;

@end

@implementation HomeViewController

- (NSMutableArray *)statusesFrame
{
    if (!_statusesFrame) {
        _statusesFrame = [NSMutableArray array];
    }
    return _statusesFrame;
}

- (PopViewController *)popViewController
{
    if (!_popViewController) {
        _popViewController = [[PopViewController alloc] init];
    }
    return _popViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setUpNavigationBar];
    
    //添加上啦控件
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
    //上啦更新
    [self.tableView headerBeginRefreshing];
    
    //添加下拉控件
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
    
    // 请求当前用户的昵称
    [UserTool userInfoWithSuccess:^(User *user) {
        // 请求当前的账号信息,并设置导航条标题
        [self.titleBtn setTitle:user.name forState:UIControlStateNormal];
        // 获取当前账号
        Account *account = [AccountTool account];
        account.name = user.name;
        // 保存用户名称
        [AccountTool saveAccount:account];
        
    } failure:^(NSError *error) {
        NSLog(@"home-->%@", error);
    }];
}

/** 刷新最新微博 */
- (void)refresh
{
    [self.tableView headerBeginRefreshing];
}

/** 加载更多 */
- (void)loadMoreStatus
{
    NSString *maxIdStr = nil;
    if (self.statusesFrame.count) {// 有微博数据彩下啦刷新
        Status *status = [[self.statusesFrame lastObject] status];
        long long maxId = [status.idstr longLongValue] - 1;
        maxIdStr = [NSString stringWithFormat:@"%lld", maxId];
    }
    //请求更多的微博数据
    [StatusTool loadMoreStatusWithMaxId:maxIdStr success:^(NSArray *statuses) {
        // 结束下啦刷新
        [self.tableView footerEndRefreshing];
        
        // 模型转视图模型
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (Status *status in statuses) {
            StatusFrame *statusFrame = [[StatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrames addObject:statusFrame];
        }
        
        // 添加数组中的元素
        [self.statusesFrame addObjectsFromArray:statusFrames];
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"moreError-->%@", error);
    }];
}

/** 加载最新 */
- (void)loadNewStatus
{
    NSString *sinceId = nil;
    if (self.statusesFrame.count) {// 有最新数据,才下拉刷新
        Status *status = [self.statusesFrame[0] status];
        sinceId = status.idstr;
    }
    //GET创建
    [StatusTool loadNewStatusWithSinceId:sinceId success:^(NSArray *statuses) {
        [self showNewStatusCount:statuses.count];
        //结束下啦刷新
        [self.tableView headerEndRefreshing];
        
        // 模型转视图模型
        NSMutableArray *statusFrames = [NSMutableArray array];
        for (Status *status in statuses) {
            StatusFrame *statusFrame = [[StatusFrame alloc] init];
            statusFrame.status = status;
            [statusFrames addObject:statusFrame];
        }
        
        // 将数据插入到最前面
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statusesFrame insertObjects:statusFrames atIndexes:indexSet];
        // 刷新数据
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"newError-->%@", error);
    }];
}

/** 显示最新为微博 */
- (void)showNewStatusCount:(NSInteger)count
{
    if (count == 0) {
        return;
    }
    CGFloat h = 35;
    CGFloat w = self.view.width;
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - h;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, w, h)];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"%ld 条最新微博", count];
    label.textAlignment = NSTextAlignmentCenter;
    // 插入导航控制器的导航条下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //动画效果
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, h);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:2 options:UIViewAnimationOptionCurveLinear animations:^{
            // 还原原始动画
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            // 移除label
            [label removeFromSuperview];
        }];
    }];
}

/** 初始化导航栏 */
- (void)setUpNavigationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_friendsearch"]
                                                                          highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"]
                                                                             target:self
                                                                             action:@selector(friendSearch)
                                                                   forControlEvents:UIControlEventTouchUpInside];
    
    // 右边
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_pop"]
                                                                           highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"]
                                                                              target:self
                                                                              action:@selector(showPop)
                                                                    forControlEvents:UIControlEventTouchUpInside];
    
    TitleButton *titleBtn = [TitleButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    [titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.adjustsImageWhenHighlighted = NO;
    self.navigationItem.titleView = titleBtn;
    self.titleBtn = titleBtn;
}

- (void)btnClick:(UIButton *)btn
{
    btn.selected = !btn.selected;
    CoverView *coverView = [CoverView show];
    coverView.delegate = self;
    
    CGFloat w = 200;
    CGFloat h = 200;
    CGFloat x = (self.view.width - w) * 0.5;
    CGFloat y = 55;
    PopMenuView *popMenu = [PopMenuView showInRect:CGRectMake(x, y, w, h)];
    popMenu.contentView = self.popViewController.view;
}

/** CoverView delegate method */
- (void)coverViewDidCover:(CoverView *)cover
{
    [PopMenuView hide];
    self.titleBtn.selected = NO;
}

- (void)friendSearch
{
    NSLog(@"%s", __func__);
    OneViewController *firstVc = [[OneViewController alloc] init];
    //只能够移除系统的tabbar
    firstVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:firstVc animated:YES];
}

- (void)showPop
{
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.statusesFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StatusViewCell *cell = [StatusViewCell cellWithTableView:tableView];
    
    // Configure the cell...
    
    StatusFrame *status = self.statusesFrame[indexPath.row];
    //给cell传递模型
    cell.statusFrame = status;

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    StatusFrame *statusFrame = self.statusesFrame[indexPath.row];
    return statusFrame.cellHeight;
}

@end
