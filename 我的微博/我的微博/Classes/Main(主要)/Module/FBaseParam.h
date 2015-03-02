//
//  FBaseParam.h
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBaseParam : NSObject

// 各种网络请求都需要 access_token， 所以创建该基类
@property (nonatomic, copy) NSString *access_token;

@end
