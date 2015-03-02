//
//  FTabBar.m
//  Weibo
//
//  Created by fenggeren on 15/1/21.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FTabBar.h"


#define kButtonsCount 5


@interface FTabBar ()

@property (nonatomic, weak) UIButton *compose;

@end

@implementation FTabBar

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addCompose];
        
    }
    
    return self;
}


// 增加 加号按钮
- (void)addCompose
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    
    [button setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
    [button addTarget:self action:@selector(modalToView) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
    self.compose = button;
}

- (void)modalToView
{
    if ([self.delegateF respondsToSelector:@selector(tabBarWithDid:)]) {
        [self.delegateF tabBarWithDid:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setupAllSubviewsFrame];

}

// 设置所有的UITabBarButton的frame
- (void)setupAllSubviewsFrame
{
    [self setupComposeButtonFrame];
    [self setupButtonsFrame];
}

// 设置添加按钮的frame
- (void)setupComposeButtonFrame
{
    CGFloat buttonW = self.width / kButtonsCount;
    CGFloat buttonH = self.height;
    
    self.compose.width = buttonW;
    self.compose.height = buttonH;
    self.compose.x = buttonW * (NSInteger)(kButtonsCount * 0.5);
    self.compose.y = 0;
}


- (void)setupButtonsFrame
{
    CGFloat buttonW = self.width / kButtonsCount;
    CGFloat buttonH = self.height;
    
    NSInteger index = 0;
    
    for (UIControl *btn in self.subviews) {
        if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) { // 遍历出子控件中所有的原始UITabBarButton控件
            btn.y = 0;
            btn.width = buttonW;
            btn.height = buttonH;
            
            if (index >= 2) { // 添加按钮 添加到了self的最中间，所以左边的按钮向左移动一格距离
                btn.x = buttonW * (index + 1);
            } else {
               btn.x = index * buttonW;
            }
            
            ++ index;
        }
    }
}
@end











