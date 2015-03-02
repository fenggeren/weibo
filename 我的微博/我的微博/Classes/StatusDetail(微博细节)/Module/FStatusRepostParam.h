//
//  FStatusRepostParam.h
//  我的微博
//
//  Created by fenggeren on 15/2/17.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//
/** 
 转发微博
 */
#import "FBaseParam.h"

@interface FStatusRepostParam : FBaseParam

/**需要查询的微博ID。 */
@property (nonatomic, copy) NSString *id;

/**若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。 */
@property (nonatomic, strong) NSNumber *since_id;

/** 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。 */
@property (nonatomic, strong) NSNumber *max_id;

/**单页返回的记录条数，最大不超过200，默认为20。 */
@property (nonatomic, strong) NSNumber *count;
@end
