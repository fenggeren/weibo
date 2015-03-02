//
//  FStatusDetailFrame.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusDetailFrame.h"
#import "FStatusOriginalFrame.h"
#import "FStatusRetweetedFrame.h"
#import "FStatus.h"

@implementation FStatusDetailFrame

- (void)setStatus:(FStatus *)status
{
    _status = status;
    
    // 先计算原微博的尺寸
    self.originalFrame = [[FStatusOriginalFrame alloc] init];
    self.originalFrame.status = status;
    
    CGFloat selfHeight = 0;
    // 再计算转发微博的尺寸(如果有的话)
    if (status.retweeted_status) {
        self.retweetedFrame = [[FStatusRetweetedFrame alloc] init];
        self.retweetedFrame.retweetedStatus = status.retweeted_status;
        // 转发微博的y,是根据original微博的尺寸计算出来的
        CGRect frame = self.retweetedFrame.frame;
        frame.origin.y = CGRectGetMaxY(self.originalFrame.frame);
        self.retweetedFrame.frame = frame;
      
        selfHeight = CGRectGetMaxY(self.retweetedFrame.frame);
    } else {
        selfHeight = CGRectGetMaxY(self.originalFrame.frame);
    }
    
    CGFloat selfWidth = FScreenWidth;
    self.frame = CGRectMake(0, FCellMargin, selfWidth, selfHeight);
}

@end
