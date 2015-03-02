//
//  FStatusOriginalFrame.h
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FStatus;

@interface FStatusOriginalFrame : NSObject

// 昵称
@property (nonatomic, assign) CGRect nameFrame;

// 头像
@property (nonatomic, assign) CGRect iconFrame;

//// 时间
//@property (nonatomic, assign) CGRect timeFrame;
//
//// 来源
//@property (nonatomic, assign) CGRect sourceFrame;

// 正文
@property (nonatomic, assign) CGRect textFrame;

// 这个view的frame
@property (nonatomic, assign) CGRect frame;

// 微博数据模型, 传给view使用
@property (nonatomic, strong) FStatus *status;

/** vip标识 */
@property (nonatomic, assign) CGRect vipFrame;

/** 微博发表的图片集 */
@property (nonatomic, assign) CGRect photosFrame;

@end














