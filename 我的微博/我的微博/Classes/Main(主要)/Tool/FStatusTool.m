//
//  FStatusTool.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusTool.h"
#import "FNetworkTool.h"
#import "FStatus.h"
#import "MJExtension.h"

#import "FHomeStatusesParam.h"
#import "FHomeStatusesResult.h"

#import "FSendStatusParam.h"
#import "FSendStatusResult.h"

#import "FConstructParams.h"

#import "FStatusCommentsResult.h"
#import "FStatusCommentsParam.h"

#import "FStatusRepostResult.h"
#import "FStatusRepostParam.h"

#import "FMDB.h"

@implementation FStatusTool

/** 数据库指针 */
static FMDatabase *_db;

/** 初始化 数据库 */
+ (void)initialize
{
    NSString *sqlpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"HomeStatuses.sqlite"];
    _db = [[FMDatabase alloc] initWithPath:sqlpath];
    
    if ([_db open]) {
        FLog(@"打开数据库成功");
        BOOL result =[_db executeUpdateWithFormat:@"CREATE TABLE IF NOT EXISTS t_home_statuses (id integer PRIMARY KEY AUTOINCREMENT, access_token text NOT NULL, status_idstr text NOT NULL, status_dict blob NOT NULL);"];
        if (result) {
            FLog(@"创建表成功");
        } else {
            FLog(@"创建表失败");
        }
    }else {
        FLog(@"打开数据库失败");
    }
}

/** 获取首页微博数据 */
+ (void)homeStatusesWithParam:(FHomeStatusesParam *)param success:(void (^)(FHomeStatusesResult *result))success failure:(void (^)(NSError *))failure
{
    NSArray *statuses = [self cachedHomeStatusesFromSqlite:param]; // 根据要求：since_id/max_id从数据库加载数据
    if (statuses.count != 0) { // 数据库有数据，则使用数据库数据；
        if (success) {
            FHomeStatusesResult *result = [[FHomeStatusesResult alloc] init];
            result.statuses = statuses;
            success(result);   
        }
        
    } else {
        NSString *url = @"https://api.weibo.com/2/statuses/home_timeline.json";
        // 将模型属性 转换为字典
        NSDictionary *dict = [param keyValues];
        
        [FNetworkTool get:url parameters:dict success:^(id dict) {
            // 存储微博 字典数组 到缓冲 数据库
            [self saveHomeStatusDictArray:dict[@"statuses"] accessToken:param.access_token];
            if (success) {
                FHomeStatusesResult *result = [FHomeStatusesResult objectWithKeyValues:dict];
                success(result);
            }
            
        } failure:^(NSError *error) {
            failure(error);
        }];
    }
}

/** 从 数据库获取 缓冲的首页微博数据 */
+ (NSArray *)cachedHomeStatusesFromSqlite:(FHomeStatusesParam *)param
{
    NSMutableArray *statuses = [NSMutableArray array];
    FMResultSet *result = nil;
    if (param.since_id) { // 查询 比since_id大的idstr的微博数据
        result = [_db executeQuery:@"SELECT * FROM t_home_statuses WHERE access_token = ? AND status_idstr > ? ORDER BY status_idstr DESC LIMIT ?", param.access_token, param.since_id, param.count];
    }else if (param.max_id){ // 查询 比max_id小的idstr的微博数据
        result = [_db executeQuery:@"SELECT * FROM t_home_statuses WHERE access_token = ? AND status_idstr <= ? ORDER BY status_idstr DESC LIMIT ?", param.access_token, param.max_id, param.count];
    }else {
        result = [_db executeQuery:@"SELECT * FROM t_home_statuses WHERE access_token = ?  ORDER BY status_idstr DESC LIMIT ?", param.access_token, param.count];
    }
    
    while (result.next) {
        NSData *data = [result objectForColumnName:@"status_dict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        FStatus *status = [FStatus objectWithKeyValues:dict];
        [statuses addObject:status];
    }
    
    return statuses;
}

/** 将微博字典数组缓冲到数据库中 */
+ (void)saveHomeStatusDictArray:(NSArray *)statusDictArray accessToken:(NSString *)accessToken
{
    for (NSDictionary *dict in statusDictArray) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
        [_db executeUpdate:@"INSERT INTO t_home_statuses (access_token, status_idstr, status_dict) VALUES (?, ?, ?);",accessToken, dict[@"idstr"], data];
    }
}

/** 微博评论 */
+ (void)statusCommentsWithParam:(FStatusCommentsParam *)param success:(void (^)(FStatusCommentsResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/comments/show.json" param:param resultClass:[FStatusCommentsResult class] success:success failure:failure];
}

/** 微博转发 */
+ (void)statusRepostsWithParam:(FStatusRepostParam *)param success:(void (^)(FStatusRepostResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/repost_timeline.json" param:param resultClass:[FStatusRepostResult class] success:success failure:failure];
}
+ (void)sendStatusesWithParam:(FSendStatusParam *)param success:(void (^)(FSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:param resultClass:[FSendStatusResult class] success:success failure:failure];
}


+ (void)sendPicByStatusesWithParam:(FSendStatusParam *)param uploadData:(NSData *)data success:(void (^)(FSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    FConstructParams *construct = [[FConstructParams alloc] init];
    construct.name = @"pic";
    construct.filename = @"image.jpg";
    construct.mimeType = @"image/jpeg";
    construct.data = data;
    
    [self postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" param:param constructParams:construct resultClass:[FSendStatusResult class] success:success failure:failure];
}

@end
















