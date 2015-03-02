//
//  FBaseTool.m
//  我的微博
//
//  Created by fenggeren on 15/2/2.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FBaseTool.h"
#import "MJExtension.h"
#import "FNetworkTool.h"

@implementation FBaseTool

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)result success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *dict = [param keyValues];
    
    [FNetworkTool get:url parameters:dict success:^(id dict) {
        if (success) {
            id r = [result objectWithKeyValues:dict];
            
            success(r);
        }
      
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)result success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *dict = [param keyValues];
    
    [FNetworkTool post:url parameters:dict success:^(id dict) {
        if (success) {
            id r = [result objectWithKeyValues:dict];
            success(r);
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param constructParams:(FConstructParams *)constructParams resultClass:(Class)result success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *dict = [param keyValues];
    
    [FNetworkTool post:url parameters:dict constructParams:constructParams success:^(id result) {
        if (success) {
            id r = [result objectWithKeyValues:dict];

            success(r);           
        }

        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end








