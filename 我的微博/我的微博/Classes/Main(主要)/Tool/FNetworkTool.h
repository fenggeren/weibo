//
//  FNetwork.h
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

/**  仅仅是为了屏蔽 第三方插件的实现细节 */

#import <Foundation/Foundation.h>

@class FConstructParams;

@interface FNetworkTool : NSObject


+ (void)get:(NSString *)url parameters:(id)params success:(void (^)(id result))sucess failure:(void (^)(NSError *error))failure;


+ (void)post:(NSString *)url parameters:(id)params success:(void (^)(id result))sucess failure:(void (^)(NSError *error))failure;

/**
 constructParams: post请求附带的 数据属性 name、filename、mimeType等
 */
+ (void)post:(NSString *)url parameters:(id)params constructParams:(FConstructParams *)constructParams success:(void (^)(id result))sucess failure:(void (^)(NSError *error))failure;


@end
