//
//  FStatusRetweetedView.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusRetweetedView.h"
#import "FStatusRetweetedFrame.h"
#import "FStatus.h"
#import "FUser.h"
#import "FStatusPhotosView.h"
#import "FStatusLabel.h"
#import "FStatusRetweetedToolBar.h"

#import "FStatusCommentsController.h"

@interface FStatusRetweetedView ()

/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;

/** 正文 */
@property (nonatomic, weak) FStatusLabel *textLabel;

/** 图片集 */
@property (nonatomic, weak) FStatusPhotosView *photosView;

/** 转发微博 工具栏--赞、评论等按钮 */
@property (nonatomic, weak) FStatusRetweetedToolBar *retweetedToolBar;
@end

@implementation FStatusRetweetedView

- (id)init
{
    if (self = [super init]) {
        // 因为图片平铺--背景色； 会有明显的痕迹；
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"timeline_retweet_background"]];
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
//        self.highlightedImage = [UIImage imageWithNamed:@"timeline_retweet_background_highlighted"];
//        self.userInteractionEnabled = YES;
        
        // 创建昵称Label
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = FNameOfRetweetedStatusFont;
        nameLabel.textColor = FColor(75, 100, 105);
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        // 创建正文text
        FStatusLabel *textLabel = [[FStatusLabel alloc] init];
//        textLabel.font = FTextOfRetweetedStatusFont;
//        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        
        // 图片集
        FStatusPhotosView *photosView = [[FStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        // 创建工具栏
        FStatusRetweetedToolBar *toolBar = [[FStatusRetweetedToolBar alloc] init];
        [self addSubview:toolBar];
        self.retweetedToolBar = toolBar;
    }
    
    return self;
}

/** 点击转发微博，进入微博详情 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取根控制器
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    // 获取导航控制器
    UINavigationController *naviVC = (UINavigationController *)tabBarVC.selectedViewController;
    
    UIViewController *viewVC = [naviVC.viewControllers firstObject];
    
    FStatusCommentsController *detailVC = [[FStatusCommentsController alloc] init];
    detailVC.status = self.retweetedFrame.retweetedStatus;
    
    [viewVC.navigationController pushViewController:detailVC animated:YES];
}

- (void)setRetweetedFrame:(FStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    FStatus *retweetedStatus = retweetedFrame.retweetedStatus;

//    self.nameLabel.text = [NSString stringWithFormat:@"@%@",user.screen_name];
//    self.nameLabel.frame = retweetedFrame.nameFrame;
   
    // 正文
    self.textLabel.attributedText = retweetedStatus.attributedString;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 图片集
    if (retweetedStatus.pic_urls.count) {
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.status = retweetedStatus;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    if (retweetedStatus.isInComments) {
        self.retweetedToolBar.frame = retweetedFrame.toolBarFrame;
        self.retweetedToolBar.status = retweetedStatus;
        self.retweetedToolBar.hidden = NO;
    } else {
        self.retweetedToolBar.hidden = YES;
    }
    
    self.frame = retweetedFrame.frame;
 
}

//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage imageWithNamed:@"timeline_retweet_background"] drawInRect:rect];
//}

@end





























