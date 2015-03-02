//
//  FAccountTool.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FAccountTool.h"
#import "FAccount.h"

#define account_file_name ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"])


@implementation FAccountTool

+ (void)saveAccount:(FAccount *)account
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:account];
    [data writeToFile:account_file_name atomically:YES];
}

+ (FAccount *)account
{
    NSData *data = [NSData dataWithContentsOfFile:account_file_name];
    FAccount *account = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSDate *cur = [NSDate date];
    NSTimeInterval interval = [account.expires_time timeIntervalSinceDate:cur];
    
    // 授权没有过期
    if (interval >= 0) {
       return account;
    } else {
        return nil;
    }
}

+ (void)accessTokenWithParam:(FAccessTokenParam *)param success:(void (^)(FAccount *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[FAccount class] success:success failure:failure];

}

@end














