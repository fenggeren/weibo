//
//  FKeyboardToolBar.m
//  Weibo
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//



#import "FKeyboardToolBar.h"

#define  kButtonBarCount  5

@interface FKeyboardToolBar ()

/** 表情键盘切换按钮 */
@property (nonatomic, weak) UIButton *emotionButton;

@end

@implementation FKeyboardToolBar

- (id)init
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"compose_toolbar_background"]];
        [self addAllButtons];
    }
    
    return self;
}

- (void)addAllButtons
{
    // 相机
    [self addButtonWithNormal:@"compose_camerabutton_background" highlighted:@"compose_camerabutton_background_highlighted" background:@"compose_camerabutton_background" andButtonType:FKeyboardToolBarButtonTypeCamera];
    
    // 图片
    [self addButtonWithNormal:@"compose_toolbar_picture" highlighted:@"compose_toolbar_picture_highlighted" background:@"compose_toolbar_picture" andButtonType:FKeyboardToolBarButtonTypePicture];
    
    // #
    [self addButtonWithNormal:@"compose_trendbutton_background" highlighted:@"compose_trendbutton_background_highlighted" background:@"compose_trendbutton_background" andButtonType:FKeyboardToolBarButtonTypeTrend];
    
    // @
    [self addButtonWithNormal:@"compose_mentionbutton_background" highlighted:@"compose_mentionbutton_background_highlighted" background:@"compose_mentionbutton_background" andButtonType:FKeyboardToolBarButtonTypeMention];
    // 表情
    self.emotionButton =  [self addButtonWithNormal:@"compose_emoticonbutton_background" highlighted:@"compose_emoticonbutton_background_highlighted" background:@"compose_emoticonbutton_background" andButtonType:FKeyboardToolBarButtonTypeEmotion];
}

- (UIButton *)addButtonWithNormal:(NSString *)normalName highlighted:(NSString *)highlightedName background:(NSString *)backgroundName andButtonType:(FKeyboardToolBarButtonType)buttonType
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageWithNamed:highlightedName] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageWithNamed:normalName] forState:UIControlStateNormal];
//    [button setBackgroundImage:[UIImage imageWithNamed:backgroundName] forState:UIControlStateNormal];
    [self addSubview:button];
    
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = buttonType;
    
    return button;
}

- (void)click:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(keyboardToolBarDidClick:withType:)]) {
        [self.delegate keyboardToolBarDidClick:self withType:(FKeyboardToolBarButtonType)button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.width / kButtonBarCount;
    CGFloat buttonH = self.height;
    CGFloat buttonY = 0;
    
    for (NSInteger i = 0; i < self.subviews.count; ++i) {
        CGFloat buttonX = i * buttonW;
        [self.subviews[i] setFrame:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
    }
}

- (void)setEmotionKeyboard:(BOOL)emotionKeyboard
{
    _emotionKeyboard = emotionKeyboard;
    
    // 改变 图标
    if (self.isEmotionKeyboard) {
        [self.emotionButton setImage:[UIImage imageWithNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    } else {
        [self.emotionButton setImage:[UIImage imageWithNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageWithNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}


@end
