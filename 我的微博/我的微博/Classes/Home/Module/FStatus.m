//
//  FStatus.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatus.h"
#import "FPhoto.h"
#import "MJExtension.h"
#import "NSDate+MJ.h"
#import "RegexKitLite.h"
#import "FRegexEmotionResult.h"
#import "FEmotionTool.h"
#import "FEmotionTextAttachment.h"
#import "FUser.h"

// 微博正文 @ ## http 的 特殊颜色
#define FStatusTextAttributeColor FColor(88, 161, 253)

@implementation FStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [FPhoto class]};
}

/** 
 
 一、今年
 1、今天
 1分钟内：刚刚
 1个小时内：xx分钟前
 
 2、昨天
 昨天 xx:xx
 
 3、至少是前天发的
 04-23 xx:xx
 
 二、非今年
 2012-07-24
 */


// 处理微博创建时间 用getter方法而不是用setter方法， 因为时间显示，会随着时间变化
- (NSString *)created_at
{
    // Thu Feb 05 15:47:12 +0800 2015
    NSString *originalStr = @"EEE MMM dd HH:mm:ss Z yyyy";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = originalStr;
    // 获取原始 日期格式的 日期
    NSDate *originalDate = [formatter dateFromString:_created_at];

    // 是否是这一年
    if ([originalDate isThisYear]) {
        if ([originalDate isToday]) { // 是否是今天
            
            NSDateComponents *components = [originalDate deltaWithNow]; // 获得和现在的时间-时分秒差距
            if (components.hour < 1) { // 一小时内
                
                if (components.minute < 1) { // 一分钟内
                    return @"刚刚";
                } else {
                    formatter.dateFormat = [NSString stringWithFormat:@"%zd分钟前", components.minute];
                    return [formatter stringFromDate:originalDate];                    
                }

            } else { // 大于一小时
                formatter.dateFormat = @"HH:mm:ss";
                return [formatter stringFromDate:originalDate];
            }
            
        } else if([originalDate isYesterday]){ // 是否是昨天
            formatter.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天 %@", [formatter stringFromDate:originalDate]];
            
        } else { // 是否是至少是今年并且是前天发的
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:originalDate];
        }

    } else { // 不是这一年，直接返回 --
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:originalDate];
    }
}

/** 
 <a href="http://weibo.com/" rel="nofollow">笑长的iPhone 5</a>
<a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
*/

//- (NSString *)source
//{
//    NSRange firstRange = [_source rangeOfString:@">"];
//    NSRange secondRange = [_source rangeOfString:@"<" options:NSBackwardsSearch];
//    NSRange range = NSMakeRange(firstRange.location + 1, secondRange.location - firstRange.location - 1);
//
//    return [_source substringWithRange:range];
//}

// getter方法 调用频繁，所以在setter方法中计算完毕；
- (void)setSource:(NSString *)source
{
    if (!source.length) return;
    
    NSRange firstRange = [source rangeOfString:@">"];
    NSRange secondRange = [source rangeOfString:@"</"];
    NSRange range = NSMakeRange(firstRange.location + 1, secondRange.location - firstRange.location - 1);
   
//    NSLog(@"%@----------%@", source, NSStringFromRange(range));
    _source = [source substringWithRange:range];
}


//- (void)setSource:(NSString *)source
//{
//    // 截取范围
//    NSRange range;
//    range.location = [source rangeOfString:@">"].location + 1;
//    range.length = [source rangeOfString:@"</"].location - range.location;
//    // 开始截取
//    NSString *subsource = [source substringWithRange:range];
//    
//    _source = [NSString stringWithFormat:@"来自%@", subsource];
//}

// 绝对让你涨姿势，人人都能做的蜂蜜柚子茶[馋嘴]
- (void)setText:(NSString *)text
{
    _text = [text copy];

    [self setAttributedString];
}

- (void)setUser:(FUser *)user
{
    _user = user;
    [self setAttributedString];
}

- (void)setRetweeted_status:(FStatus *)retweeted_status
{
    _retweeted_status = retweeted_status;
    [self setAttributedString];
}

// 根据 文本，还原富文本
/** 
 1.是否是转发微博
 2.正文已经赋值
 3.昵称已经赋值
 */
- (void)setAttributedString
{
    // 如果没有给 正文 和 作者赋值，则返回
    if (!self.text || !self.user) return;
    
    NSString *completeText = nil;
    if (!self.retweeted_status) { // 如果是转发微博， 则昵称和正文连在一起 -- 拥有转发微博，一定不是转发微博
        completeText = [NSString stringWithFormat:@"@%@: %@", self.user.screen_name, self.text];
    }else {
        completeText = self.text;
    }
    
    self.attributedString = [self attributedWithString:completeText];
}


- (NSAttributedString *)attributedWithString:(NSString *)text
{
    // 正则表达式，找出表情的说明文字 [呲牙]
    NSString *regex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    
    // 找出表情说明文字
    NSMutableArray *array = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        FRegexEmotionResult *result = [[FRegexEmotionResult alloc] init];
        result.text = *capturedStrings;
        result.range = *capturedRanges;
        result.emotion = YES;
        [array addObject:result];
    }];
    
    // 使用表情文字，分割出文字-
    [text enumerateStringsSeparatedByRegex:regex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        FRegexEmotionResult *result = [[FRegexEmotionResult alloc] init];
        result.text = *capturedStrings;
        result.range = *capturedRanges;
        result.emotion = NO;
        [array addObject:result];
    }];
    
    // 排序
    [array sortUsingComparator:^NSComparisonResult(FRegexEmotionResult *result1, FRegexEmotionResult *result2){
        NSUInteger loc1 = result1.range.location;
        NSUInteger loc2 = result1.range.location;
        return [@(loc1) compare:@(loc2)];
    }];
    
    // 组合富文本;
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] init];
    // 遍历文本数组
    [array enumerateObjectsUsingBlock:^(FRegexEmotionResult *result, NSUInteger idx, BOOL *stop) {
        // 因为有些表情，手机显示不出来[赞], 但是电脑显示出来，所以手机应该显示文字
        FEmotionModule *module = [FEmotionTool emotionWithName:result.text];
        
        if (result.isEmotion && module) { // 是表情图片
            FEmotionTextAttachment *attach = [[FEmotionTextAttachment alloc] init];
            attach.emotion = module;
            attach.bounds = CGRectMake(0, -3, FTextOfStatusFont.lineHeight, FTextOfStatusFont.lineHeight);
            NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:attach];
            [attri appendAttributedString:str];
        } else { // 是纯文本(或emoji)
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:result.text];
            
            //@提到 #话题# 超链接 文字增加高亮
            NSArray *addAttri = @[
                                  @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-]+ ?",
                                  @"#[a-zA-Z0-9\\u4e00-\\u9fa5\\-]+#",
                                  @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?"
                                  ];
            for (NSString *color in addAttri) {
                [result.text enumerateStringsMatchedByRegex:color usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                    [str addAttribute:NSForegroundColorAttributeName value:FStatusTextAttributeColor range:*capturedRanges];
                    // 增加自定义属性， 为了处理微博正文中的超链接事件，如：@--- #----# http://---
                    [str addAttribute:FAttributedStringOfStatus value:*capturedStrings range:*capturedRanges];
                }];
            }
            
            [attri appendAttributedString:str];
        }
    }];
    
    
    [attri addAttribute:NSFontAttributeName value:FTextOfStatusFont range:NSMakeRange(0, attri.length)];
    
    return attri;
}

@end



















