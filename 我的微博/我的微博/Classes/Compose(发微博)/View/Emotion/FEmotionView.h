//
//  FEmotionView.h
//  我的微博
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//
// 用于显示 表情的 按钮


#import <UIKit/UIKit.h>

@class FEmotionModule;

@interface FEmotionView : UIButton

@property (nonatomic, strong) FEmotionModule *module;

@end
