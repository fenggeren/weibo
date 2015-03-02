//
//  FStatusDetailView.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusDetailView.h"
#import "FStatusOriginalView.h"
#import "FStatusRetweetedView.h"
#import "FStatusRetweetedFrame.h"
#import "FStatusDetailFrame.h"
#import "FStatus.h"
#import "FUser.h"

@interface FStatusDetailView ()
/** 原微博 */
@property (nonatomic, weak) FStatusOriginalView *originalView;
/** 转发微博 */
@property (nonatomic, weak) FStatusRetweetedView *retweetedView;

@end

@implementation FStatusDetailView

- (id)init
{
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        
        FStatusOriginalView *originalView = [[FStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        FStatusRetweetedView *retweetedView = [[FStatusRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    
    return self;
}

- (void)setDetailFrame:(FStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    if (detailFrame.status.retweeted_status) { // 存在转发微博
        self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
        self.retweetedView.hidden = NO;
    } else {
        self.retweetedView.hidden = YES;
    }
    
    self.frame = detailFrame.frame;
}

@end
