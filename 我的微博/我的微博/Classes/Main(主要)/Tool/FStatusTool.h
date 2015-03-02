//
//  FStatusTool.h
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

/**业务类，完成各项功能 */


#import "FBaseTool.h"

@class FHomeStatusesParam, FHomeStatusesResult;
@class FSendStatusParam, FSendStatusResult;
@class FStatusCommentsParam, FStatusCommentsResult;
@class FStatusRepostParam, FStatusRepostResult;
// 需要上传的文件类型
//typedef enum {
//    FPostDataOfMimeTypeJson, // Json文件
//    FPostDataOfMimeTypeTxt, // 文本文件
//    FPostDataOfMimeTypeImage, // 图片文件
//    FPostDataOfMimeTypeXML    //XML文件
//}FPostDataOfMimeType;

@interface FStatusTool : FBaseTool

// 获取 首页 微博数据
+ (void)homeStatusesWithParam:(FHomeStatusesParam *)param success:(void (^) (FHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/** 获取微博评论 */
+ (void)statusCommentsWithParam:(FStatusCommentsParam *)param success:(void (^) (FStatusCommentsResult *result))success failure:(void (^)(NSError *error))failure;

/** 获取微博转发信息 */
+ (void)statusRepostsWithParam:(FStatusRepostParam *)param success:(void (^) (FStatusRepostResult *result))success failure:(void (^)(NSError *error))failure;

// 发 微博
+ (void)sendStatusesWithParam:(FSendStatusParam *)param success:(void (^) (FSendStatusResult *result))success failure:(void (^)(NSError *error))failure;


// 发 带图片的微博
+ (void)sendPicByStatusesWithParam:(FSendStatusParam *)param uploadData:(NSData *)data success:(void (^) (FSendStatusResult *result))success failure:(void (^)(NSError *error))failure;

//// 上传 数据
//+ (void)sendDataWithParam:(FSendStatusParam *)param uploadData:(NSData *)data success:(void (^) (FSendStatusResult *result))success failure:(void (^)(NSError *error))failure;


@end
