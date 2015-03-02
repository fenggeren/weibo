//
//  FUserTool.h
//  我的微博
//
//  Created by fenggeren on 15/2/2.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//


#import "FBaseTool.h"

@class FUserInfoParam, FUserInfoResult, FUserUnreadCountParam, FUserUnreadCountResult;

@interface FUserTool : FBaseTool

// 获取 账号信息
+ (void)userInfoWithParam:(FUserInfoParam *)param success:(void (^) (FUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

// 获取用户 未读的各种数据个数
+ (void)userUnreadCountWithParam:(FUserUnreadCountParam *)param success:(void (^) (FUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
