//
//  FSettingItem.h
//  我的微博
//
//  Created by fenggeren on 15/2/11.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSettingItem : NSObject

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon detailTitle:(NSString *)detailTitle;

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

/** 图标 */
@property (nonatomic, copy) NSString *icon;

/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 说明 */
@property (nonatomic, copy) NSString *detailTitle;

/** 点击cell后，跳转到该vc */
@property (nonatomic, assign) Class selectedVC;

/** 点击cell，不跳转需要执行的功能 */
@property (nonatomic, copy) void (^operate)();

/** 红色背景的按钮的title */
@property (nonatomic, copy) NSString *badgeValue;
@end


