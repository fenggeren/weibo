//
//  FEmotionToolBar.m
//  我的微博
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionToolBar.h"

@interface FEmotionToolBar ()

@property (nonatomic, weak) UIButton *selectedBtn;

@end

@implementation FEmotionToolBar

- (id)init
{
    if (self = [super init]) {
        [self setupButton:@"常用" :FEmotionToolBarButtonTypeCommonly];
        self.selectedBtn = [self setupButton:@"默认" :FEmotionToolBarButtonTypeDefault];
        [self setupButton:@"emojy" :FEmotionToolBarButtonTypeEmoji];
        [self setupButton:@"浪小花" :FEmotionToolBarButtonTypeLxh];
        
        // ！！！放到这里，其代理还没设置，所以代理方法不会调用，so，重写代理方法
//        [self btnClick:button];
    }
    
    return self;
}

- (UIButton *)setupButton:(NSString *)title :(FEmotionToolBarButtonType)buttonType
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = buttonType;
    [self addSubview:button];
    
    if (buttonType == FEmotionToolBarButtonTypeCommonly) {
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (buttonType == FEmotionToolBarButtonTypeLxh){
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }else {
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}

- (void)setDelegate:(id<FEmotionToolBarDelegate>)delegate
{
    _delegate = delegate;
    
    [self btnClick:self.selectedBtn];
}

- (void)btnClick:(UIButton *)button
{
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    if ([self.delegate respondsToSelector:@selector(emotionToolBarDidClick:buttonType:)]) {
        [self.delegate emotionToolBarDidClick:self buttonType:(FEmotionToolBarButtonType)button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    
    CGFloat width = self.width / count;
    CGFloat height = self.height;
    for (NSInteger i = 0; i < count; ++i) {
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(i * width, 0, width, height);
    }
}

@end
