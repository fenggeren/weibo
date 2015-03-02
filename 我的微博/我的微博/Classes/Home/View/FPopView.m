//
//  FPopView.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FPopView.h"

@interface FPopView ()

//// 需要显示的view
@property (nonatomic, weak) UIView *displayView;

// 覆盖整个self的按钮
@property (nonatomic, weak) UIButton *coverView;

// 需要显示的容器
@property (nonatomic, weak) UIImageView *containerView;


@end


@implementation FPopView

- (instancetype)initWithView:(UIView *)view
{
    if (self = [super init]) {
        UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
        [cover addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.coverView = cover;
        
        UIImageView *container = [[UIImageView alloc] init];
        container.userInteractionEnabled = YES;
        [self addSubview:container];
        container.image = [UIImage imageWithNamed:@"popover_background"];
        self.containerView = container;

        [self.containerView addSubview:view];
        self.displayView = view;
    }
    
    return self;
}

+ (instancetype)popWithView:(UIView *)view
{
    return [[self alloc] initWithView:view];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.coverView.frame = [UIScreen mainScreen].bounds;
}

- (void)showInRect:(CGRect)rect
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;
    [window addSubview:self];

//    self.containerView.frame = rect;
//    self.containerView.width += 10;
//    self.containerView.height += 20;
//    self.containerView.x -= 5;
//    self.containerView.y -= 10;
    self.containerView.frame = rect;
    // 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    self.displayView.y = topMargin;
    self.displayView.x = leftMargin;
    self.displayView.width = self.containerView.width - leftMargin - rightMargin;
    self.displayView.height = self.containerView.height - topMargin - bottomMargin;
    
    UIImage *image = self.containerView.image;
    self.containerView.image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
//    UIEdgeInsets edge = UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5);
//    self.containerView.image = [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
}

// 从父控件中移除
- (void)dismissView
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
    [self removeFromSuperview];
}


@end













