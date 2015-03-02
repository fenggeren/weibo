//
//  FRooterControllerTool.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FRooterControllerTool.h"
#import "FTabBarController.h"
#import "NewFeatureController.h"

@implementation FRooterControllerTool
+ (void)chooseRooterController
{
    //    CFBundleVersion
    NSString *versionKey = (__bridge NSString*)kCFBundleVersionKey;
    // 获取运行版本
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    // 获取上次运行的版本
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *preVersion = [user objectForKey:versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 必将上、本次版本是否一致，
    if ([preVersion isEqualToString:curVersion]) {
        FTabBarController *tabBarVc = [[FTabBarController alloc] init];
        [window setRootViewController:tabBarVc];
    } else { // 不一致，则为新版本，显示新特性
        [user setObject:curVersion forKey:versionKey];
        NewFeatureController *new = [[NewFeatureController alloc] init];
        window.rootViewController = new;
    }

}

@end
