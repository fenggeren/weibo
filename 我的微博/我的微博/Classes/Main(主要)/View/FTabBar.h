//
//  FTabBar.h
//  Weibo
//
//  Created by fenggeren on 15/1/21.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FTabBar;

@protocol FTabBarDelegate <NSObject>

@optional

- (void)tabBarWithDid:(FTabBar *)tabBar;

@end

@interface FTabBar : UITabBar

@property (nonatomic, weak) id<FTabBarDelegate> delegateF;

@end
