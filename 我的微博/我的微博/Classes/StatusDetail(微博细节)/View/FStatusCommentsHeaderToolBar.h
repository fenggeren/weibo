//
//  FStatusCommentsHeaderToolBar.h
//  我的微博
//
//  Created by fenggeren on 15/2/17.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//
/** 
 评论控制器 header工具条
 */

#import <UIKit/UIKit.h>

@class FStatus, FStatusCommentsHeaderToolBar;

typedef enum {
    FStatusCommentsHeaderToolBarButtonTypeRepost,
    FStatusCommentsHeaderToolBarButtonTypeComment,
    FStatusCommentsHeaderToolBarButtonTypeAttribute
}FStatusCommentsHeaderToolBarButtonType;

@protocol FStatusCommentsHeaderToolBarDelegate <NSObject>

@optional
- (void)headerToolBarDidSelected:(FStatusCommentsHeaderToolBar *)toolBar buttonType:(FStatusCommentsHeaderToolBarButtonType)buttonType;

@end

@interface FStatusCommentsHeaderToolBar : UIView

@property (nonatomic, weak) id<FStatusCommentsHeaderToolBarDelegate> delegate;

@property (nonatomic, strong) FStatus *status;

/** 现在选择的按钮类型 */ /** 在这里 而不是在控制器中定义--- 面向对象-封装性 */
@property (nonatomic, assign) FStatusCommentsHeaderToolBarButtonType buttonType;

@end
