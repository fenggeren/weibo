//
//  FEmotionToolBar.h
//  我的微博
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

// 按钮类型 -- tag
typedef enum {
    FEmotionToolBarButtonTypeCommonly,
    FEmotionToolBarButtonTypeDefault,
    FEmotionToolBarButtonTypeEmoji,
    FEmotionToolBarButtonTypeLxh
}FEmotionToolBarButtonType;

@class FEmotionToolBar;

@protocol FEmotionToolBarDelegate <NSObject>

@optional
- (void)emotionToolBarDidClick:(FEmotionToolBar *)toolbar buttonType:(FEmotionToolBarButtonType)buttonType;

@end


@interface FEmotionToolBar : UIView

@property (nonatomic, weak) id<FEmotionToolBarDelegate> delegate;

@end
