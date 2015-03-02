//
//  FStatusBaseToolBar.m
//  我的微博
//
//  Created by fenggeren on 15/2/16.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusBaseToolBar.h"
#import "FStatus.h"

@interface FStatusBaseToolBar ()

//转发数
@property (nonatomic, weak) UIButton *repostButton;

//评论数
@property (nonatomic, weak) UIButton *commentButton;

//表态数
@property (nonatomic, weak) UIButton *attitudeButton;

/** 存储按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation FStatusBaseToolBar


- (id)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.repostButton = [self setupButtonWith:@"timeline_icon_retweet" title:@"转发"];
        self.commentButton = [self setupButtonWith:@"timeline_icon_comment" title:@"评论"];
        self.attitudeButton = [self setupButtonWith:@"timeline_icon_unlike" title:@"赞"];
        
    }
    
    return self;
}
- (NSArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (UIButton *)setupButtonWith:(NSString *)icon title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithNamed:icon] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    // 设置高亮背景图片
    [button setBackgroundImage:[UIImage resizedImage:@"common_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    
    // 设置按钮标题 左移10点；  让图片和文字分离10点
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 高亮时， 图片不变色(暗)
    button.adjustsImageWhenHighlighted = NO;
    
    [self addSubview:button];
    
    [self.buttons addObject:button];
    
    return button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.buttons.count;
    
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    CGFloat buttonY = 0;
    for (NSInteger i = 0; i < count; ++i) {
        UIButton *button = self.buttons[i];
        CGFloat buttonX = buttonW * i;
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

@end
