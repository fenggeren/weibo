//
//  FRegexEmotionResult.h
//  我的微博
//
//  Created by fenggeren on 15/2/9.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//
/** 
 用于接收到微博数据， 将微博正文转换为富文本形式， 使用正则表达式分割正文， 得到的几个属性组成一个模型
 */
#import <Foundation/Foundation.h>

@interface FRegexEmotionResult : NSObject

/** 文字说明 */
@property (nonatomic, copy) NSString *text;

/** 文字在整个正文的范围 */
@property (nonatomic, assign) NSRange range;

/** 是否是 表情图片 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;

@end
