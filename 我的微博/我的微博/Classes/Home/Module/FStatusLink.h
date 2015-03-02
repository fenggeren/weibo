//
//  FStatusLink.h
//  我的微博
//
//  Created by fenggeren on 15/2/10.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FStatusLink : NSObject

/** 用于存放，一个微博正文的 一个特殊字段的所有rects<当该字段占用两行> */
@property (nonatomic, strong) NSArray *rects;

/** 范围 */
@property (nonatomic, assign) NSRange range;

/** 特殊字段 */
@property (nonatomic, copy) NSString *text;
@end
