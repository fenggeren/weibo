//
//  FStatusRepostResult.h
//  我的微博
//
//  Created by fenggeren on 15/2/17.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FStatusRepostResult : NSObject

/** 用于存储 微博转发模型 的数组 */
@property (nonatomic, strong) NSArray *reposts;

/** 评论总数 */
@property (nonatomic, copy) NSNumber *total_number;

@end
