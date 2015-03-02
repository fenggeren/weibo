//
//  FEmotionPop.h
//  我的微博
//
//  Created by fenggeren on 15/2/7.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FEmotionView;

@interface FEmotionPop : UIView

+ (instancetype)pop;

/** 显示 */
- (void)showTheEmotion:(FEmotionView *)emotionView;

/** 取消 */
- (void)dismiss;

@end
