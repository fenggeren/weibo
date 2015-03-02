//
//  FSettingGroup.h
//  我的微博
//
//  Created by fenggeren on 15/2/11.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSettingGroup : NSObject

+ (instancetype)group;

/** 组 头标题 */
@property (nonatomic, copy) NSString *header;

/** 组 脚标题 */
@property (nonatomic, copy) NSString *footer;

/** 存放Item模型 */
@property (nonatomic, strong) NSArray *items;

@end
