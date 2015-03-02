//
//  FEmotionTool.h
//  我的微博
//
//  Created by fenggeren on 15/2/7.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FEmotionModule;

@interface FEmotionTool : NSObject

/** 浪小花表情 */
+(NSArray *)lxhEmotions;

/** 默认表情 */
+(NSArray *)defaultEmotions;

/** emoji表情 */
+(NSArray *)emojiEmotions;

/** 最近的表情 */
+ (NSArray *)recentEmotions;

/** 添加最近使用的表情 */
+ (void)addRecentEmotion:(FEmotionModule *)emotion;

/** 根据表情说明，返回表情模型 */
+ (FEmotionModule *)emotionWithName:(NSString *)name;

@end
