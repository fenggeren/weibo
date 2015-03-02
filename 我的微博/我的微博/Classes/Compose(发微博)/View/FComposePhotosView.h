//
//  FComposePhotosView.h
//  Weibo
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FComposePhotosView : UIView

// 添加图片
- (void)addImage:(UIImage *)image;

// 获取所有的图片--   面向对象 封装性
- (NSArray *)images;

@end
