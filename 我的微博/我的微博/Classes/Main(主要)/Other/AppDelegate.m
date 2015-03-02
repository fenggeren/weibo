//
//  AppDelegate.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "AppDelegate.h"
#import "OAuthViewController.h"
#import "FRooterControllerTool.h"
#import "FAccountTool.h"
#import "FAccount.h"
#import "UIImageView+WebCache.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    application.statusBarHidden = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [self.window makeKeyAndVisible];
    
////    CFBundleVersion
//    NSString *versionKey = (__bridge NSString*)kCFBundleVersionKey;
//    NSString *curVersion = [NSBundle mainBundle].infoDictionary[versionKey];
//    
//    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
//    NSString *preVersion = [user objectForKey:versionKey];
//    
//    if ([preVersion isEqualToString:curVersion]) {
//        FTabBarController *tabBarVc = [[FTabBarController alloc] init];
//        
//        [self.window setRootViewController:tabBarVc];
//    } else {
//        [user setObject:curVersion forKey:versionKey];
//        NewFeatureController *new = [[NewFeatureController alloc] init];
//        self.window.rootViewController = new;
//    }
    FAccount *account = [FAccountTool account];
    if (account) { // 账号已经授权，存储
        // 选择 跟控制器
        [FRooterControllerTool chooseRooterController];
    } else { // 进入账号授权
         self.window.rootViewController = [[OAuthViewController alloc] init];
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

// 程序进入后台后调用
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // 提醒操作系统 当前这个应用程序在后台开启一个任务；
    // 操作系统允许这个应用程序在后台保持运行状态 能够持续的时间不确定
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
       // 后台运行的时间到期了，救护izhidong调用这个block
        [application endBackgroundTask:taskID];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    // 停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}

@end
