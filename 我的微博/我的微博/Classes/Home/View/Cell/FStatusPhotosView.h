//
//  FStatusPhotosView.h
//  我的微博
//
//  Created by fenggeren on 15/2/5.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FStatus;

@interface FStatusPhotosView : UIView

/** 根据图片数量，计算出图片集的尺寸 */
+ (CGSize)sizeWithCount:(NSInteger)count;

@property (nonatomic, strong) FStatus *status;

@end
