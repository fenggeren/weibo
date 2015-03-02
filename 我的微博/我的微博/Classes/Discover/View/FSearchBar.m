//
//  FSearchBar.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FSearchBar.h"

@implementation FSearchBar

+ (instancetype)searchBar
{
    FSearchBar *text = [[FSearchBar alloc] init];
    text.width = 300;
    text.height = 32;
    
    UIImageView *left = [[UIImageView alloc] init];
    left.width = text.height;
    left.height = left.width;
    left.image = [UIImage imageWithNamed:@"searchbar_textfield_search_icon"];
    // 设置view的图片为原图片大小，并且居中显示
    left.contentMode = UIViewContentModeCenter;
    text.leftView =left;

    UIImage *bgImage = [UIImage imageWithNamed:@"searchbar_textfield_background"];
    bgImage = [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width * 0.5 topCapHeight:bgImage.size.height * 0.5];
    
    text.background = bgImage;
    
    // 设置写入字符 垂直居中
    text.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    text.leftViewMode = UITextFieldViewModeAlways;
    text.clearButtonMode = UITextFieldViewModeAlways;
    
    
    return text;
}

@end
