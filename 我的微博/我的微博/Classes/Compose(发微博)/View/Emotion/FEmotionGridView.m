//
//  FEmotionGridView.m
//  我的微博
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionGridView.h"
#import "FEmotionView.h"
#import "FEmotionPop.h"
#import "FEmotionTool.h"

@interface FEmotionGridView ()

/** 存放显示表情的 FEmotionView */
@property (nonatomic, strong) NSMutableArray *emotionBtns;

/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteBtn;

@property (nonatomic, strong) FEmotionPop *popView;
/** 是否在长按手势中 */
@property (nonatomic, assign, getter = isInLongPress) BOOL inLongPress;

@end

@implementation FEmotionGridView

- (NSMutableArray *)emotionBtns
{
    if (!_emotionBtns) {
        _emotionBtns = [NSMutableArray array];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageWithNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageWithNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(deleteEmotion:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.deleteBtn = button;
    }
    return _emotionBtns;
}
- (FEmotionPop *)popView
{
    if (!_popView) {
        self.popView = [FEmotionPop pop];
    }
    return _popView;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    // 需要显示的 表情 数量
    NSInteger count = emotions.count;
    // 需要重复利用
    for (NSInteger i = 0; i < count; ++i) {
        FEmotionView *view = nil;
        if (i < self.emotionBtns.count) {
            view = self.emotionBtns[i];
        } else {
            view = [[FEmotionView alloc] init];
            view.adjustsImageWhenHighlighted = NO;
            [view addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:view];
            [self.emotionBtns addObject:view];
            
            UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
            [view addGestureRecognizer:recognizer];
        }
        view.module = self.emotions[i];
        view.hidden = NO;
    }
    
    for (NSInteger i = count; i < self.emotionBtns.count; ++i) {
        [self.emotionBtns[i] setHidden:YES];
    }
    
    [self setNeedsLayout];
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint pos = [recognizer locationInView:self];
    FEmotionView *view = [self touchedEmotion:pos];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        if (view) { // 手在一个表情按钮上松开，则选中此按钮
            [self selectedEmotion:view];
        }
        [self.popView dismiss];
    } else if (view){
        [self.popView showTheEmotion:view];
    }
}

// 选中了某个表情，添加到输入框
- (void)selectedEmotion:(FEmotionView *)emotion
{
    if (emotion == nil) return;
    // 发送选中表情通知
    [[NSNotificationCenter defaultCenter] postNotificationName:FEmotionDidSelectedNotification object:nil userInfo:@{FEmotionDidSelectedKey : emotion.module}];
    [FEmotionTool addRecentEmotion:emotion.module];
}

// 删除表情通知
- (void)deleteEmotion:(UIButton *)deleteBtn
{
    // 发送选中表情通知
    [[NSNotificationCenter defaultCenter] postNotificationName:FEmotionDidDeleteNotification object:nil userInfo:nil];
}


/** 长安手势中-- 触摸中的表情 */
- (FEmotionView *)touchedEmotion:(CGPoint) pos
{
    for (FEmotionView *view in self.emotionBtns) {
        if (view.hidden) break;
        if (CGRectContainsPoint(view.frame, pos)) return view;
    }
    return nil;
}

// 点击表情按钮， 弹出一个view
- (void)emotionClick:(FEmotionView *)emotionBtn
{
    [self selectedEmotion:emotionBtn];
    // 换图片时，默认有动画，这里不需要动画， 但是这个方法是禁止这个程序的动画，所以需要在动画改完后，恢复动画；
    [UIView setAnimationsEnabled:NO];
    
    [self.popView showTheEmotion:emotionBtn];
   
    // 切换玩图片后， 恢复动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView setAnimationsEnabled:YES];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
    });
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnWidth = 32;
    CGFloat btnHeight = btnWidth;
    
    CGFloat btnMarginX = (self.width - kEmotionMaxCols * btnWidth) / (kEmotionMaxCols + 1);
    CGFloat btnMarginY = (self.height - kEmotionMaxRows * btnHeight) / (kEmotionMaxRows + 1);
    // i 可以从小于 就的self.emotionBtns.count开始计算，因为就的btn已经设置完毕
    for (NSInteger i = 0; i < self.emotionBtns.count; i++) {
        FEmotionView *view = self.emotionBtns[i];
        if (view.hidden) break; // 隐藏的按钮，不处理
        view.width = btnWidth;
        view.height = btnHeight;
        view.x = (i % kEmotionMaxCols) * (btnWidth + btnMarginX) + btnMarginX;
        view.y = (i / kEmotionMaxCols) * (btnHeight + btnMarginY) + btnMarginY;
    }
    
    // 设置删除按钮的frame
    self.deleteBtn.width = 36;
    self.deleteBtn.height = 32;
    self.deleteBtn.x = self.width - btnMarginX - self.deleteBtn.width;
    self.deleteBtn.y = self.height - btnMarginY - self.deleteBtn.height;
}

@end
