//
//  FNavigationController.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FNavigationController.h"
#import "UIBarButtonItem+Extension.h"

@implementation FNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 不是根控制器
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWith:@"navigationbar_more" selectedName:@"navigationbar_more_highlighted" target:self action:@selector(backToRoot)];
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWith:@"navigationbar_back" selectedName:@"navigationbar_back_highlighted" target:self action:@selector(backToRoot)];
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)backToRoot
{
    [self popToRootViewControllerAnimated:YES];
}

- (void)backToPre
{
    [self popViewControllerAnimated:YES];
}

// 该方法在程序运行过程中，只会调用一次，无聊呢创建几个对象;
+ (void)initialize
{
    [self setupBarButtonAttributes];
    [self setupNavigationAttributes];
}

// 设置设置Navigation栏上两边按钮UIBarButtonItem的的属性
+ (void)setupBarButtonAttributes
{
    UIBarButtonItem *bar = [UIBarButtonItem appearance];
    
    // 为了让某个按钮的背景消失，可以设置一个完全透明的背景；
    [bar setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    NSMutableDictionary *norDict = [NSMutableDictionary dictionary];
    
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    norDict[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [bar setTitleTextAttributes:norDict forState:UIControlStateNormal];
    
    NSMutableDictionary *selDict = [NSMutableDictionary dictionaryWithDictionary:norDict];
    selDict[NSForegroundColorAttributeName] = [UIColor redColor];
    [bar setTitleTextAttributes:selDict forState:UIControlStateHighlighted];
    
    NSMutableDictionary * disableDict= [NSMutableDictionary dictionary];
    disableDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [bar setTitleTextAttributes:disableDict forState:UIControlStateDisabled];
}

// 设置Navigation栏上的title的属性
+ (void)setupNavigationAttributes
{
    UINavigationBar *nav = [UINavigationBar appearance];
    
    if (!iOS7) {
        [nav setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = NavigationTitleFont;
    dict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [nav setTitleTextAttributes:dict];
}
@end
