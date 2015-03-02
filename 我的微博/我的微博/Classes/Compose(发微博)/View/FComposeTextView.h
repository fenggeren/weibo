//
//  FComposeTextView.h
//  Weibo
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FComposeTextView, FEmotionModule;

@protocol FComposeTextViewDelegate <NSObject>

@optional
- (void)composeTextViewDidEnable:(FComposeTextView *)textView enableSend:(BOOL)enable;

@end

@interface FComposeTextView : UITextView

// 占位符
@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, weak) id<FComposeTextViewDelegate> delegateCompose;


@end
