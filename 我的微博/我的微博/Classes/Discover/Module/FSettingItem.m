//
//  FSettingItem.m
//  我的微博
//
//  Created by fenggeren on 15/2/11.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FSettingItem.h"

@implementation FSettingItem

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon detailTitle:(NSString *)detailTitle
{
    FSettingItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    item.detailTitle = detailTitle;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon
{
    return [self itemWithTitle:title icon:icon detailTitle:nil];
}


@end
