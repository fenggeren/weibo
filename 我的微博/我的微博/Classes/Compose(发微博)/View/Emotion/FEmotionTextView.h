//
//  FEmotionTextView.h
//  我的微博
//
//  Created by fenggeren on 15/2/9.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//
/** 
 富文本输入view
 */
#import "FComposeTextView.h"

@interface FEmotionTextView : FComposeTextView


/** 插入表情符号 */
- (void)insertEmotion:(FEmotionModule *)emotion;

/** 返回富文本的 文本形式<图片用说明代替> */
- (NSString *)attributedString;
@end
