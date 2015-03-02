//
//  FComposePhotosView.m
//  Weibo
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FComposePhotosView.h"

#define kCountImagePerRow 4

@implementation FComposePhotosView

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGFloat margin = 10;
    CGFloat viewW = (self.width - (kCountImagePerRow + 1) * margin) / kCountImagePerRow;
    CGFloat viewH = viewW;

    NSInteger count = self.subviews.count;
    for (NSInteger i = 0; i < count; ++i) {
        UIImageView *imageView = self.subviews[i];
        imageView.width = viewW;
        imageView.height = viewH;
        imageView.x = (i % kCountImagePerRow) * (viewW + margin) + margin;
        imageView.y = (i / kCountImagePerRow) * (viewH + margin);
        NSLog(@"%@", NSStringFromCGRect(imageView.frame));
    }
}

- (NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    
    return array;
}

@end
