//
//  FStatusCommentsHeaderToolBar.m
//  我的微博
//
//  Created by fenggeren on 15/2/17.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusCommentsHeaderToolBar.h"
#import "FStatus.h"

@interface FStatusCommentsHeaderToolBar ()

//转发数
@property (nonatomic, weak) UIButton *repostButton;

//评论数
@property (nonatomic, weak) UIButton *commentButton;

//表态数
@property (nonatomic, weak) UIButton *attitudeButton;

/** 三角形标识 */
@property (nonatomic, weak) UIImageView *arrow;
/** 分割线 */
@property (nonatomic, weak) UIImageView *separator;

@property (nonatomic, weak) UIButton *selected;
@end

@implementation FStatusCommentsHeaderToolBar

- (id)init
{
    if (self = [super init]) {
        self.backgroundColor = FTableViewBackgroundColor;
        self.repostButton = [self setupButtonWithTitle:@"转发" andButtonType:FStatusCommentsHeaderToolBarButtonTypeRepost];
        self.commentButton = [self setupButtonWithTitle:@"评论" andButtonType:FStatusCommentsHeaderToolBarButtonTypeComment];
        self.attitudeButton = [self setupButtonWithTitle:@"赞" andButtonType:FStatusCommentsHeaderToolBarButtonTypeAttribute];
        
        // 分割线
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"statusdetail_comment_line"]];
        [self addSubview:imageView];
        self.separator = imageView;
        
        // 三角标识
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"statusdetail_comment_top_arrow"]];
        [self addSubview:arrow];
        self.arrow = arrow;
    }
    
    return self;
}

- (UIButton *)setupButtonWithTitle:(NSString *)title andButtonType:(FStatusCommentsHeaderToolBarButtonType) buttonType
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:button];

    [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = buttonType;
    
    return button;
}

- (void)selected:(UIButton *)button
{
    
    if ([self.delegate respondsToSelector:@selector(headerToolBarDidSelected:buttonType:)]) {
        [self.delegate headerToolBarDidSelected:self buttonType:(FStatusCommentsHeaderToolBarButtonType)button.tag];
    }
    if (button.tag == FStatusCommentsHeaderToolBarButtonTypeAttribute) return; // 点击赞按钮
    
    button.selected = YES;
    self.selected.selected = NO;
    self.selected = button;
    self.buttonType = (FStatusCommentsHeaderToolBarButtonType)button.tag;
    
    CGPoint center = self.arrow.center;
    center.x = button.center.x;
    self.arrow.center = center;
}

#pragma mark 重写设置代理
- (void)setDelegate:(id<FStatusCommentsHeaderToolBarDelegate>)delegate
{
    _delegate = delegate;
    [self selected:self.commentButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 按钮之间的空隙
    CGFloat buttonY = 5;
    CGFloat buttonH = 25;
    CGFloat buttonW = 70;
    CGFloat buttonX = 0;
    
    // 转发
    self.repostButton.frame = CGRectMake(0, buttonY, buttonW, buttonH);
    // 分割线
    buttonX = buttonX + CGRectGetMaxX(self.repostButton.frame) + 1;
    self.separator.center = CGPointMake(buttonX, self.repostButton.center.y);
    //评论
    buttonX += 1;
    self.commentButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    // 三角标识
    self.arrow.center = CGPointMake(self.commentButton.center.x, self.height - 7);
    
    //赞
    buttonX = self.width - buttonW;
    self.attitudeButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    
}

- (void)setStatus:(FStatus *)status
{
    _status = status;
    
    [self setupBtnTitle:self.repostButton title:status.reposts_count.intValue default:@"转发"];
    [self setupBtnTitle:self.commentButton title:status.comments_count.intValue default:@"评论"];
    [self setupBtnTitle:self.attitudeButton title:status.attitudes_count.intValue default:@"赞"];
    
}

- (void)setupBtnTitle:(UIButton *)button title:(int)count default:(NSString *)defaultTitle
{
    if (count >= 10000) {
        defaultTitle = [NSString stringWithFormat:@"%.1f万 %@", count / 10000.0, defaultTitle];
        // 如果是正万.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if(count > 0){
        defaultTitle = [NSString stringWithFormat:@"%d %@", count, defaultTitle];
    }
    
    [button setTitle:defaultTitle forState:UIControlStateSelected];
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}

- (void)drawRect:(CGRect)rect
{
    rect.origin.y = 5;
    [[UIImage resizedImage:@"statusdetail_comment_top_background"] drawInRect:rect];
}

@end
