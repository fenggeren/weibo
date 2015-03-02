//
//  UIImage+Suit.h
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Suit)

/** 用于适配ios6/7的不同图片名 _ios7 */
+ (instancetype)imageWithNamed:(NSString *)name;

/** 用于不变形拉伸图片 */
+ (instancetype)resizedImage:(NSString *)name;
@end
