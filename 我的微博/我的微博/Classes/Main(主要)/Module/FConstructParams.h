//
//  FConstructParams.h
//  我的微博
//
//  Created by fenggeren on 15/2/2.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

/** post网络请求中需要附带的数据属性 name、filename、mimeType等 */

#import <Foundation/Foundation.h>

@interface FConstructParams : NSObject

@property (nonatomic, copy) NSString *filename;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *mimeType;

@property (nonatomic, strong) NSData *data;

@end
