//
//  FEmotionView.m
//  我的微博
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionView.h"
#import "FEmotionModule.h"

@implementation FEmotionView

- (void)setModule:(FEmotionModule *)module
{
    _module = module;
    // emoji区别于图片 利用第三方框架处理 显示；
    if (!module.code) {
        NSString *name = [NSString stringWithFormat:@"%@/%@", module.doc, module.png];
        UIImage *image = [UIImage imageWithNamed:name];
        if (iOS7) { // ios7 默认渲染成蓝色， 设为原图，不需要渲染
            image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:@"" forState:UIControlStateNormal];
    } else { // emoji
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:module.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
    }
}

@end
