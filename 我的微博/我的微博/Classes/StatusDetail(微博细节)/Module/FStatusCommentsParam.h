//
//  FStatusesDetailParam.h
//  我的微博
//
//  Created by fenggeren on 15/2/16.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

/** 用于获取网络请求的发送参数 */

#import "FHomeStatusesParam.h"

@interface FStatusCommentsParam : FHomeStatusesParam

/** id	true	int64	需要查询的微博ID。 */
@property (nonatomic, copy) NSString *id;

@end
