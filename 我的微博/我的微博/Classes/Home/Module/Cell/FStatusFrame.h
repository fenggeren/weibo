//
//  FStatusFrame.h
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FStatus, FStatusDetailFrame;

@interface FStatusFrame : NSObject

@property (nonatomic, strong) FStatus *status;

@property (nonatomic, strong) FStatusDetailFrame *detailFrame;

@property (nonatomic, assign) CGRect toobarFrame;

/** 计算出Cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
