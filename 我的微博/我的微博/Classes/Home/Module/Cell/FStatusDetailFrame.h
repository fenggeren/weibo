//
//  FStatusDetailFrame.h
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FStatus, FStatusOriginalFrame, FStatusRetweetedFrame;

@interface FStatusDetailFrame : NSObject

/** 微博模型 */
@property (nonatomic, strong) FStatus *status;

/** self的frame */
@property (nonatomic, assign) CGRect frame;

@property (nonatomic, strong) FStatusOriginalFrame *originalFrame;

@property (nonatomic, strong) FStatusRetweetedFrame *retweetedFrame;


@end
