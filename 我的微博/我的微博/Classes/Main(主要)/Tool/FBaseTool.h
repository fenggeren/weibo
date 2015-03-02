//
//  FBaseTool.h
//  我的微博
//
//  Created by fenggeren on 15/2/2.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FConstructParams;

@interface FBaseTool : NSObject

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)result success:(void (^) (id result))success failure:(void (^)(NSError *error))failure;

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)result success:(void (^) (id result))success failure:(void (^)(NSError *error))failure;

// 上传 数据constructParams 上传数据 属性模型
+ (void)postWithUrl:(NSString *)url param:(id)param constructParams:(FConstructParams *)constructParams resultClass:(Class)result success:(void (^) (id result))success failure:(void (^)(NSError *error))failure;

@end
