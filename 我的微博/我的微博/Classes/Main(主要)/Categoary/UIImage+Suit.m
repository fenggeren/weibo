//
//  UIImage+Suit.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "UIImage+Suit.h"

@implementation UIImage (Suit)

+ (instancetype)imageWithNamed:(NSString *)name
{
    UIImage *image = nil;
    
    if (iOS7) {
        NSString *nameOS7 = [name stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:nameOS7];
    }
    
    // iOS7版本以下 或则 没有iOS7专用的图片
    if (!image) {
        image = [UIImage imageNamed:name];
    }
    
    return image;
}

+ (instancetype)resizedImage:(NSString *)name
{
    UIImage *image = [UIImage imageWithNamed:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
