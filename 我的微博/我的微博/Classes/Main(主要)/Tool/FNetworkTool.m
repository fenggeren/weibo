//
//  FNetwork.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FNetworkTool.h"
#import "AFNetworking.h"
#import "FAccountTool.h"
#import "FAccount.h"
#import "FConstructParams.h"

@implementation FNetworkTool

+ (void)get:(NSString *)url parameters:(id)params success:(void (^)(id))sucess failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sucess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)post:(NSString *)url parameters:(id)params success:(void (^)(id))sucess failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];

    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (sucess) {
          sucess(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
           failure(error);
        }
    }];
}

+ (void)post:(NSString *)url parameters:(id)params constructParams:(FConstructParams *)constructParams success:(void (^)(id))sucess failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
        [formData appendPartWithFileData:constructParams.data name:constructParams.name fileName:constructParams.filename mimeType:constructParams.mimeType];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        sucess(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];

}


@end
















