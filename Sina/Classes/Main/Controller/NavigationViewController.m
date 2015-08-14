//
//  NavigationViewController.m
//  Sina
//
//  Created by James on 3/6/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController () <UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation NavigationViewController

+ (void)initialize
{
    //获取当前类的所有UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    //设置导航栏的颜色
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count != 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_back"] highImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] target:self action:@selector(backPre) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(backRoot) forControlEvents:UIControlEventTouchUpInside];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)backPre
{
    NSLog(@"%s", __func__);
    [self popViewControllerAnimated:YES];
}

- (void)backRoot
{
    NSLog(@"%s", __func__);
    [self popToRootViewControllerAnimated:YES];
}

/****************	UINavigationController delegate   ****************/

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        //还原代理属性
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
        UITabBarController *tableVc = (UITabBarController *)KeyWindow.rootViewController;
        
        //移除系统的tabbar
        for (UIView *tabBarBtn in tableVc.tabBar.subviews) {
            if ([tabBarBtn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [tabBarBtn removeFromSuperview];
            }
        }
    } else {
        //清空手势代理
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
