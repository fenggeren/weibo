//
//  FStatusRetweetedFrame.h
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FStatus;

@interface FStatusRetweetedFrame : NSObject

/**  转发微博模型 */
@property (nonatomic, strong) FStatus *retweetedStatus;

/**  昵称 */
//@property (nonatomic, assign) CGRect nameFrame;

/**  转发微博正文 */
@property (nonatomic, assign) CGRect textFrame;

/** self的frame */
@property (nonatomic, assign) CGRect frame;

/** 微博发表的图片集 */
@property (nonatomic, assign) CGRect photosFrame;
/** 转发微博工具栏 */
@property (nonatomic, assign) CGRect toolBarFrame;
@end
