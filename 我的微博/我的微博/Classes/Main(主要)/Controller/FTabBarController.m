//
//  FTabBarController.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FTabBarController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MsgViewController.h"
#import "MeViewController.h"
#import "ComposeViewController.h"

#import "FNavigationController.h"
#import "FTabBar.h"

#import "FUserTool.h"
#import "FUserUnreadCountResult.h"
#import "FUserUnreadCountParam.h"

#import "FAccount.h"
#import "FAccountTool.h"
@interface FTabBarController () <FTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, weak) HomeViewController *home;

@property (nonatomic, weak) MsgViewController *msg;

@property (nonatomic, weak) MeViewController *profile;

@property (nonatomic, weak) DiscoverViewController *discover;

// 上次选择的控制器
@property (nonatomic, weak) UIViewController *preSelectedVc;

@end

@implementation FTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self setupTabBarAttributes];
    [self setupTabBar];
    
    [self unreadCount];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(unreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    // 现在选择的vc
    id curVc = [viewController.viewControllers lastObject];
    // 现在点击的 是 现在正在显示的控制器 TabBarButton;
    if ( self.preSelectedVc == curVc && [curVc isKindOfClass:[HomeViewController class]]) {
        [self.home refreshNewStatuses];
    }
    
    self.preSelectedVc = [viewController.viewControllers lastObject];
}

- (void)unreadCount
{
    FUserUnreadCountParam *param = [[FUserUnreadCountParam alloc] init];
    param.uid = [FAccountTool account].uid;
    
    [FUserTool userUnreadCountWithParam:param success:^(FUserUnreadCountResult *result) {
        
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        } else {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        }
        
        if (result.messageCount == 0) {
            self.msg.tabBarItem.badgeValue = nil;
        } else {
            self.msg.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        }
        
        if (result.totalCount) {
            self.profile.tabBarItem.badgeValue = nil;
        } else {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        }
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;

    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

// 初始化 TabBar上的按钮；
- (void)setupTabBar
{
   // 将self的TabBar变为自己创建的继承自TabBar的对象；因为有个+号按钮有背景无法直接添加到TabBar上面，所以需要自定义；
    //
    FTabBar *tabBar = [[FTabBar alloc] init];
    tabBar.delegateF = self;
    [self setValue:tabBar  forKey:@"tabBar"];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addController:home title:@"首页" normalImage:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    self.home = home;
    
    MsgViewController *msg = [[MsgViewController alloc] init];
    [self addController:msg title:@"信息" normalImage:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    self.msg = msg;
//    MsgViewController *compose = [[MsgViewController alloc] init];
//    [self addController:compose title:@"" normalImage:@"tabbar_compose_icon_add" selectedImage:@"tabbar_compose_icon_add_highlighted"];
    
    
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addController:discover title:@"发现" normalImage:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    self.discover = discover;
    
    MeViewController *profile = [[MeViewController alloc] init];
    [self addController:profile title:@"我" normalImage:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    self.profile = profile;
}

- (void)addController:(UIViewController *)viewVc title:(NSString *)title normalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage;
{
    viewVc.title = title;

    viewVc.tabBarItem.image = [UIImage imageWithNamed:normalImage];
    
    UIImage *selImage = [UIImage imageWithNamed:selectedImage];
    
    if (iOS7) {
    // 在iOS7及以上版本，tabBar的UITabBarButton选择后，会默认渲染为蓝色
        selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }

    viewVc.tabBarItem.selectedImage = selImage;
    
    FNavigationController *nav = [[FNavigationController alloc] initWithRootViewController:viewVc];
    
    [self addChildViewController:nav];
}

// 设置设置界面最下面TabBar栏上的按钮UITabBarItem的的属性
- (void)setupTabBarAttributes
{
    UITabBarItem *tab = [UITabBarItem appearance];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [tab setTitleTextAttributes:dict forState:UIControlStateSelected];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}


- (void)tabBarWithDid:(FTabBar *)tabBar
{
    ComposeViewController *vc = [[ComposeViewController alloc] init];
    

    FNavigationController *nav = [[FNavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
}


@end























