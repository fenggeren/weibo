//
//  FUnreadParam.h
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FBaseParam.h"

@interface FUserUnreadCountParam : FBaseParam

// 需要获取消息未读数的用户UID，必须是当前登录用户。
@property (nonatomic, copy) NSString *uid;

@end
