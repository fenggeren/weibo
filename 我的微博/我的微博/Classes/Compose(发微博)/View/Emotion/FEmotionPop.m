//
//  FEmotionPop.m
//  我的微博
//
//  Created by fenggeren on 15/2/7.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionPop.h"
#import "FEmotionView.h"

@interface FEmotionPop ()

@property (weak, nonatomic) IBOutlet FEmotionView *emotionView;

@end

@implementation FEmotionPop

+ (instancetype)pop
{
    return [[[NSBundle mainBundle] loadNibNamed:@"FEmotionPop" owner:nil options:nil] lastObject];
}

- (void)showTheEmotion:(FEmotionView *)emotionView
{
    if (emotionView == nil) {
        return;
    }
    // 不使用keyWindow因为它不一定是最上面的window---有键盘的时候，
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.emotionView.module = emotionView.module;
    [window addSubview:self];
    self.center = CGPointMake(emotionView.center.x, emotionView.center.y - self.height * 0.5);
    self.center = [window convertPoint:self.center fromView:emotionView.superview];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

@end
