//
//  FAccessToken.h
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

/**
 {
 "access_token" = "2.004r3QxB9E9IvB6bea7c438ajGR94B";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 1791837781;
 }
 */

#import <Foundation/Foundation.h>

@interface FAccount : NSObject <NSCoding>

//+ (instancetype)accountWithDict:(NSDictionary *)dict;


//"access_token" = "2.004r3QxB9E9IvB6bea7c438ajGR94B";
@property (nonatomic, copy) NSString *access_token;

//"expires_in" = 157679999;
@property (nonatomic, copy) NSString *expires_in;

// 授权过期时间
@property (nonatomic, strong) NSDate *expires_time;

//"remind_in" = 157679999; access_token的生命周期（该参数即将废弃，开发者请使用expires_in）
//@property (nonatomic, copy) NSString *remind_in;

//uid = 1791837781;
@property (nonatomic, copy) NSString *uid;

/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;

@end
