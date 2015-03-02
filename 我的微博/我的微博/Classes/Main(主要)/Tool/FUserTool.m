//
//  FUserTool.m
//  我的微博
//
//  Created by fenggeren on 15/2/2.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FUserTool.h"
#import "FNetworkTool.h"
#import "MJExtension.h"
#import "FUserInfoParam.h"
#import "FUserInfoResult.h"

#import "FUserUnreadCountParam.h"
#import "FUserUnreadCountResult.h"

@implementation FUserTool



+ (void)userInfoWithParam:(FUserInfoParam *)param success:(void (^)(FUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    
    // 将模型属性 转换为字典
    NSDictionary *dict = [param keyValues];
    
    [FNetworkTool get:url parameters:dict success:^(NSDictionary *dict) {
        if (success) {
             // dict 用户信息 字典， 用户信息模型
            FUserInfoResult *result = [FUserInfoResult objectWithKeyValues:dict];
            success(result);           
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];

//    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[FUserInfoResult class] success:success failure:failure];
}

+ (void)userUnreadCountWithParam:(FUserUnreadCountParam *)param success:(void (^)(FUserUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    NSString *url = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    
    // 将模型属性 转换为字典
    NSDictionary *dict = [param keyValues];
    
    [FNetworkTool get:url parameters:dict success:^(NSDictionary *dict) {
        if (success) {
            FUserUnreadCountResult *result = [FUserUnreadCountResult objectWithKeyValues:dict];
            success(result);
        }

    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        
    }];
}


@end









