//
//  FStatusToolBar.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusToolBar.h"
#import "FStatus.h"

@interface FStatusToolBar ()

/** 存储分割线 */
@property (nonatomic, strong) NSMutableArray *separators;

@end

@implementation FStatusToolBar

- (id)init
{
    if (self = [super init]) {
        [self setupSeparator];
        [self setupSeparator];
    }
    
    return self;
}

- (NSArray *)separators
{
    if (!_separators) {
        _separators = [NSMutableArray array];
    }
    return _separators;
}

// 设置 按钮间的 分割线
- (void)setupSeparator
{
    UIImageView *separator = [[UIImageView alloc] init];
    separator.image = [UIImage imageWithNamed:@"timeline_card_bottom_line"];
//    separator.highlightedImage = [UIImage imageWithNamed:@"timeline_card_bottom_line_highlighted"];
    separator.contentMode = UIViewContentModeCenter;
    [self addSubview:separator];
    
    [self.separators addObject:separator];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = 3;
    CGFloat buttonW = self.width / count;
    
    for (NSInteger i = 0; i < self.separators.count; ++i) {
        UIImageView *separator = self.separators[i];
        separator.width = 4;
        separator.height = self.height;
        separator.center = CGPointMake((i + 1) * buttonW, self.height * 0.5);
    }
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"timeline_card_bottom_background"] drawInRect:rect];
}

@end
















