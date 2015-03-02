//
//  FEmotionTool.m
//  我的微博
//
//  Created by fenggeren on 15/2/7.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionTool.h"
#import "FEmotionModule.h"
#import "MJExtension.h"

#define FEmotionRecentUse ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recentEmotions.data"])



@implementation FEmotionTool
/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;
/** 最近使用的表情 */
static NSMutableArray *_recentEmotions;

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [FEmotionModule objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDoc:) withObject:@"EmotionIcons/default"];
    }
    
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [FEmotionModule objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDoc:) withObject:@"EmotionIcons/emoji"];
    }
    
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [FEmotionModule objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDoc:) withObject:@"EmotionIcons/lxh"];
    }
    
    return _lxhEmotions;
}

+ (NSArray *)recentEmotions
{
    if (!_recentEmotions) {
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:FEmotionRecentUse];
        if (!_recentEmotions) { // 沙盒中没有数据
            _recentEmotions = [NSMutableArray array];
        }
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:FEmotionRecentUse];
}

+ (void)addRecentEmotion:(FEmotionModule *)emotion
{
    [self recentEmotions];
//    // 匹配是否有相同的表情
//    FEmotionModule *module = nil;
//    for (NSInteger i = 0; i < _recentEmotions.count; ++i) {
//        module = _recentEmotions[i];
//        if ([emotion isEqual:module]) {
//            [_recentEmotions removeObject:module];
//            break;
//        }
//    }
    
    // 删除就的 相同的表情
    [_recentEmotions removeObject:emotion];
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:FEmotionRecentUse];
}



+ (FEmotionModule *)emotionWithName:(NSString *)name
{
    if (!name) return nil;
    
    __block FEmotionModule *emotion = nil;
    //遍历默认表情，找出匹配
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(FEmotionModule *module, NSUInteger idx, BOOL *stop) {
        if ([name isEqualToString:module.chs] || [name isEqualToString:module.cht]) {
            emotion = module;
            *stop = YES;
        }
    }];
    if (emotion) return emotion;
    
    //遍历浪小花表情，找出匹配
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(FEmotionModule *module, NSUInteger idx, BOOL *stop) {
        if ([name isEqualToString:module.chs] || [name isEqualToString:module.cht]) {
            emotion = module;
            *stop = YES;
        }
    }];
    return emotion;
}

@end

















