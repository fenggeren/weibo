//
//  FSettingBadgeView.m
//  我的微博
//
//  Created by fenggeren on 15/2/13.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FSettingBadgeView.h"

@implementation FSettingBadgeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageWithNamed:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    if (size.width > self.currentBackgroundImage.size.width) {
        [self setBackgroundImage:[UIImage resizedImage:@"main_badge"] forState:UIControlStateNormal];
        size.width += 10;
    }
    self.size = size;
    
    [super setTitle:title forState:state];
}

@end
