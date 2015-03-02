//
//  FPopView.h
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPopView : UIView

- (instancetype)initWithView:(UIView *)view;

/*
    传入要显示的view； 该view可以包含自动以多个控件。。
 */
+ (instancetype)popWithView:(UIView *)view;


// 需要显示的控件的 尺寸
- (void)showInRect:(CGRect)rect;

// 移除该对象时，需要做
@property (nonatomic, copy) void (^dismissBlock)(void);


@end
