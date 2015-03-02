//
//  FImage.h
//  我的微博
//
//  Created by fenggeren on 15/2/6.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FImage : NSObject

/** 需要下载的高清图片 */
@property (nonatomic, copy) NSString *url;

/** 需要显示的图片 */
@property (nonatomic, strong) UIImage *image;

/** 图片的原始显示位置 */
@property (nonatomic, assign) CGRect oriFrame;

@end
