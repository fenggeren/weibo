//
//  FAccountTool.h
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FBaseTool.h"

@class FAccount, FAccessTokenParam;

@interface FAccountTool : FBaseTool

// 存储账号
+ (void)saveAccount:(FAccount *)account;

// 获取账号
+ (FAccount *)account;

// 获取 首页 微博数据
+ (void)accessTokenWithParam:(FAccessTokenParam *)param success:(void (^) (FAccount *result))success failure:(void (^)(NSError *error))failure;

@end
