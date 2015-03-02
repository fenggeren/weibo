//
//  NewFeatureController.m
//  Weibo
//
//  Created by fenggeren on 15/1/21.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "NewFeatureController.h"
#import "FTabBarController.h"
#define kImageCount 4

@interface NewFeatureController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation NewFeatureController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupScroll];
    [self setupPageControl];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)setupScroll
{
    UIScrollView *scroll = [[UIScrollView alloc] init];
    scroll.frame = self.view.bounds;
    scroll.contentSize = CGSizeMake(kImageCount * scroll.width, scroll.height);
    
    for (NSInteger i = 0; i < kImageCount; ++i) {
        NSString *name = [NSString stringWithFormat:@"new_feature_%ld", i + 1];
        UIImage *image = [UIImage imageWithNamed:name];
        
        UIImageView *view = [[UIImageView alloc] initWithImage:image];
        view.x = scroll.width * i;
        view.y = 0;
        view.width = scroll.width;
        view.height = scroll.height;
        
        [scroll addSubview:view];
        
        if (i == kImageCount - 1) {
            view.userInteractionEnabled = YES;
            [self setupShareButton:view];
            [self setupEnterButton:view];
        }
    }
    
    scroll.pagingEnabled = YES;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.delegate = self;
    scroll.bounces = NO;
    [self.view addSubview:scroll];
}

// 代理方法，将UIPageControl和UIScrollView联系到一起
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat indexF = scrollView.contentOffset.x / scrollView.width;
    NSInteger index = (indexF + 0.5);
    
    self.pageControl.currentPage = index;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////


- (void)setupPageControl
{
    UIPageControl *page = [[UIPageControl alloc] init];
    page.numberOfPages = kImageCount;
    page.currentPageIndicatorTintColor = [UIColor redColor];
    page.pageIndicatorTintColor = [UIColor blueColor];
    page.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.9);
    self.pageControl = page;
    [self.view addSubview:page];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 创建最后的分享按钮
- (void)setupShareButton:(UIView *)view
{
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.width = self.view.width * 0.4;
    share.height = 40;
    share.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.6);
    [share setTitle:@"分享给大家" forState:UIControlStateNormal];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [share setImage:[UIImage imageWithNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [share setImage:[UIImage imageWithNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:share];
}

- (void)share:(UIButton *)button
{
    button.selected = !button.selected;
}

// 创建最后的进入微博按钮
- (void)setupEnterButton:(UIView *)view
{
    UIButton *enter = [UIButton buttonWithType:UIButtonTypeCustom];
    [enter setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [enter setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [enter setTitle:@"开始微博" forState:UIControlStateNormal];
    enter.size = enter.currentBackgroundImage.size;
    enter.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.75);
    
    [enter addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:enter];
}

- (void)enter
{
    FTabBarController *vc = [[FTabBarController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window setRootViewController:vc];
    
}

@end






















