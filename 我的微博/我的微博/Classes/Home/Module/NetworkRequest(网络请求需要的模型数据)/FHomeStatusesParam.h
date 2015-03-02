//
//  FHomeStatusesParam.h
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

/** 使用对象而不是 long long的原因：
 使用MJ的模型转字典，如果属性是基本类型，则默认是0； 而如果是对象默认是nil；
 在新浪微博获取首页微博数据时，如果count默认是20； 如果是基本类型，就不会获得数据；而如果是nil就会使用默认的20；
 */

#import "FBaseParam.h"

@interface FHomeStatusesParam : FBaseParam

@property (nonatomic, strong) NSNumber *since_id;

@property (nonatomic, strong) NSNumber *max_id;

@property (nonatomic, strong) NSString *count;

@end
