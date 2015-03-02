//
//  FStatusFrame.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusFrame.h"
#import "FStatusDetailFrame.h"
#import "FStatus.h"

@implementation FStatusFrame

- (void)setStatus:(FStatus *)status
{
    _status = status;
    
    // 计算 微博和转发微博的尺寸
    self.detailFrame = [[FStatusDetailFrame alloc] init];
    self.detailFrame.status = status;
    
    // 设置toolBar的在cell理的frame
    CGFloat toolbarWidth = FScreenWidth;
    CGFloat toolbarHeight = 35;
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    self.toobarFrame = CGRectMake(toolbarX, toolbarY, toolbarWidth, toolbarHeight);
    
    self.cellHeight = CGRectGetMaxY(self.toobarFrame);
}

@end
