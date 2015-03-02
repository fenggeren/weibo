//
//  FEmotionTextAttachment.h
//  我的微博
//
//  Created by fenggeren on 15/2/9.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//
/** 
 用于将富文本转换为纯文本是使用，
 */
#import <UIKit/UIKit.h>

@class FEmotionModule;

@interface FEmotionTextAttachment : NSTextAttachment

@property (nonatomic, strong) FEmotionModule *emotion;

@end
