//
//  FKeyboardToolBar.h
//  Weibo
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

// 工具栏上的 按钮 类型
typedef enum {
    FKeyboardToolBarButtonTypeCamera,
    FKeyboardToolBarButtonTypePicture,
    FKeyboardToolBarButtonTypeTrend,
    FKeyboardToolBarButtonTypeMention,
    FKeyboardToolBarButtonTypeEmotion
} FKeyboardToolBarButtonType;

@class FKeyboardToolBar;

@protocol FKeyboardToolBarDelegate <NSObject>

@optional
- (void)keyboardToolBarDidClick:(FKeyboardToolBar *)toolBar withType:(FKeyboardToolBarButtonType)type;

@end

@interface FKeyboardToolBar : UIView

@property (nonatomic, weak) id<FKeyboardToolBarDelegate> delegate;

/** 是否在使用表情键盘 */
@property (nonatomic, assign, getter = isEmotionKeyboard) BOOL emotionKeyboard;

@end
