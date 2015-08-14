//
//  AppDelegate.m
//  Sina
//
//  Created by James on 3/5/15.
//  Copyright (c) 2015 James. All rights reserved.
//

#import "AppDelegate.h"
#import "OAuthViewController.h"
#import "RootTool.h"
#import "AccountTool.h"
#import "Account.h"
#import "UIImageView+WebCache.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 注册通知
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [application registerUserNotificationSettings:setting];
    
    //设置音频会话
    AVAudioSession *session = [AVAudioSession sharedInstance];
    // 设置后台播放
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 判断账号是否授权,跳转不同的控制器
    if ([AccountTool account]) {
        [RootTool chooseRootViewController:self.window];
    } else {
        OAuthViewController *oauthVc = [[OAuthViewController alloc] init];
        self.window.rootViewController = oauthVc;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

/** 接收到内存警告的时候 */
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 停止所有的下载
    [[SDWebImageManager sharedManager] cancelAll];
    //删除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

/** 失去焦点 */
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"silence.mp3" withExtension:nil];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [player prepareToPlay];
    // 无限播放
    player.numberOfLoops = -1;
//    [player play];
    self.player = player;
}

/** 进入后台进程 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // 开启一个后台进程
    UIBackgroundTaskIdentifier ID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 结束后台进程
        [application endBackgroundTask:ID];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    [self.player stop];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
