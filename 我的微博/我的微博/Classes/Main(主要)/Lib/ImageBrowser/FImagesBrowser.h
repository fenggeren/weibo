//
//  FImagesBrowser.h
//  我的微博
//
//  Created by fenggeren on 15/2/6.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FImagesBrowser : UIViewController

/** 需要浏览的图片 */
@property (nonatomic, strong) NSArray *images;

/** 需要显示的图片序号 */
@property (nonatomic, assign) NSInteger curIndex;

/** 显示图片 */
- (void)show;
@end
