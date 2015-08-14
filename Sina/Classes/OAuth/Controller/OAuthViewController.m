//
//  OAuthViewController.m
//  Sina
//
//  Created by James on 3/9/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "OAuthViewController.h"
#import "MBProgressHUD+Extension.h"
#import "AFNetworking.h"
#import "Account.h"
#import "AccountTool.h"
#import "RootTool.h"

@interface OAuthViewController () <UIWebViewDelegate>

@end

@implementation OAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSString *baseUrl = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id = @"263066535";
    NSString *redirect_uri = @"http://www.baidu.com";
    
    NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@", baseUrl, client_id, redirect_uri];
    //创建路径
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    webView.delegate = self;
}

/****************	Web View delegate   ****************/

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 加载请求,用于拦截webView
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        NSString *rangeStr = [urlStr substringFromIndex:range.location + range.length];
        [self accessTokenWithCode:rangeStr];
        return NO;
    }
    return YES;
}

/** 获取accessToken */
- (void)accessTokenWithCode:(NSString *)code
{
    [AccountTool accountWithCode:code success:^{
        // 进去主页或者新特性,选择窗口根控制器
        [RootTool chooseRootViewController:KeyWindow];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.description);
    }];
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
