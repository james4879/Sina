//
//  TabBarViewController.m
//  Sina
//
//  Created by James on 3/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "TabBarViewController.h"
#import "TabBarView.h"

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "NavigationViewController.h"

#import "UserTool.h"
#import "UserResult.h"
#import "ComposeViewController.h"

@interface TabBarViewController () <TabBarViewDelegate>

/** 保存tabbarItem */
@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, strong) HomeViewController *home;

@property (nonatomic, strong) MessageViewController *messge;

@property (nonatomic, strong) ProfileViewController *profile;

@property (nonatomic, strong) DiscoverViewController *discover;

@end

@implementation TabBarViewController

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpTabBarController];
    
    [self setUpTabBarItem];
    
    //每个一段时间请求一次未读信息数
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(requestUnRead) userInfo:nil repeats:YES];
}

/** 请求未读信息数 */
- (void)requestUnRead
{
    //请求微博的未读信息数
    [UserTool unReadWithSuccess:^(UserResult *result) {
        // 设置首页的未读信息数
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        // 设置信息界面的未读信息数
        self.messge.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        // 设置我的未读信息数
        self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        // 设置应用所有的未读信息数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
        
    } failure:^(NSError *error) {
        NSLog(@"unRead-->%@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //移除系统的tabbar
    for (UIView *tabBarBtn in self.tabBar.subviews) {
        if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarBtn removeFromSuperview];
        }
    }
}

/** 初始化tabBarItem */
- (void)setUpTabBarItem
{
    TabBarView *tabBarView = [[TabBarView alloc] initWithFrame:self.tabBar.bounds];
    tabBarView.items = self.items;
    tabBarView.delegate = self;
    tabBarView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview:tabBarView];
}

/** 初始化tabbar */
- (void)setUpTabBarController
{
    //首页
    HomeViewController *home = [[HomeViewController alloc] init];
    home.view.backgroundColor = [UIColor grayColor];
    [self setUpOneChildViewController:home
                                image:[UIImage imageWithOriginalName:@"tabbar_home"]
                        selectedImage:[UIImage imageWithOriginalName:@"tabbar_home_selected"]
                                title:@"首页"];
    self.home = home;
    
    //消息
    MessageViewController *message = [[MessageViewController alloc] init];
    [self setUpOneChildViewController:message
                                image:[UIImage imageWithOriginalName:@"tabbar_message_center"]
                        selectedImage:[UIImage imageWithOriginalName:@"tabbar_message_center_selected"]
                                title:@"消息"];
    self.messge = message;
    
    //发现
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self setUpOneChildViewController:discover
                                image:[UIImage imageWithOriginalName:@"tabbar_discover"]
                        selectedImage:[UIImage imageWithOriginalName:@"tabbar_discover_selected"]
                                title:@"发现"];
    self.discover = discover;
    
    //我
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    [self setUpOneChildViewController:profile
                                image:[UIImage imageWithOriginalName:@"tabbar_profile"]
                        selectedImage:[UIImage imageWithOriginalName:@"tabbar_profile_selected"]
                                title:@"我"];
    self.profile = profile;
}

/**
 *  添加一个子控制器
 *
 *  @param vc            控制器
 *  @param image         tabbar的图片
 *  @param selectedImage tabbar的选择图片
 *  @param title         tabbar标题
 */
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage title:(NSString *)title
{
    vc.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    [self.items addObject:vc.tabBarItem];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

/****************************** TabBarButton delegate method *********************************/
- (void)tabBar:(TabBarView *)tabBar didClickAtIndex:(NSInteger)index
{
    if (index == 0 && self.selectedIndex == index) {// 点击首页刷新列表
        [self.home refresh];
    }
    self.selectedIndex = index;
}

/** tabBar点击加好按钮 */
- (void)tabBarDidClickPlusButton:(TabBarView *)tabBar
{
    ComposeViewController *compose = [[ComposeViewController alloc] init];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
