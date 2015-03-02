//
//  FStatusCommentToolBar.m
//  我的微博
//
//  Created by fenggeren on 15/2/16.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusCommentsToolBar.h"
#import "FStatus.h"

@interface FStatusCommentsToolBar ()

//转发数
@property (nonatomic, weak) UIButton *repostButton;

//评论数
@property (nonatomic, weak) UIButton *commentButton;

//表态数
@property (nonatomic, weak) UIButton *attitudeButton;
@end

@implementation FStatusCommentsToolBar

- (id)init
{
    if (self = [super init]) {
        self.repostButton = [self setupButtonWith:@"statusdetail_icon_retweet" title:@"转发"];
        self.commentButton = [self setupButtonWith:@"statusdetail_icon_comment" title:@"评论"];
        self.attitudeButton = [self setupButtonWith:@"statusdetail_icon_like" title:@"赞"];
        
    }
    
    return self;
}

- (UIButton *)setupButtonWith:(NSString *)icon title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithNamed:icon] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设置按钮标题 左移10点；  让图片和文字分离10点
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    [self addSubview:button];
    
    return button;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    // 按钮之间的空隙
    CGFloat marginX = 10;
    CGFloat marginY = 5;
    CGFloat buttonW = (self.width - marginX * (count + 1)) / count;
    CGFloat buttonH = self.height - marginY * 2;
    CGFloat buttonY = marginY;
    for (NSInteger i = 0; i < count; ++i) {
        UIButton *button = self.subviews[i];
        CGFloat buttonX = (buttonW + marginX) * i + marginX;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
    
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
        defaultTitle = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        // 如果是正万.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if(count > 0){
        defaultTitle = [NSString stringWithFormat:@"%d", count];
    }
    
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"statusdetail_toolbar_background"] drawInRect:rect];
}

@end
