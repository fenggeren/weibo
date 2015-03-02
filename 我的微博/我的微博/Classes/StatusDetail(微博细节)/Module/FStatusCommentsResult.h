//
//  FStatusesDetailResult.h
//  我的微博
//
//  Created by fenggeren on 15/2/16.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FStatusCommentsResult : NSObject

/** 用于存储 微博评论模型 的数组 */
@property (nonatomic, strong) NSArray *comments;

/** 评论总数 */
@property (nonatomic, copy) NSNumber *total_number;
@end
