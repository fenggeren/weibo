//
//  FStatusRetweetedFrame.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusRetweetedFrame.h"
#import "FStatus.h"
#import "FUser.h"
#import "FStatusPhotosView.h"

@implementation FStatusRetweetedFrame

/** 传进来的就是一个转发微博 */
- (void)setRetweetedStatus:(FStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // self的高度
    CGFloat selfHeight = 0;
    
    // 正文
    CGFloat textX = FContentOfCellInset;
    CGFloat textY = FContentOfCellInset * 0.5;
    CGSize textMaxSize = CGSizeMake(FScreenWidth - 2 * FContentOfCellInset, CGFLOAT_MAX);
    CGSize textSize = [retweetedStatus.attributedString boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.textFrame = (CGRect){textX, textY, textSize};
    
    selfHeight = CGRectGetMaxY(self.textFrame) + FContentOfCellInset * 0.5;

    // 图片集
    if (retweetedStatus.pic_urls.count) {
        CGSize photosSize = [FStatusPhotosView sizeWithCount:retweetedStatus.pic_urls.count];
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + FContentOfCellInset;
        self.photosFrame = (CGRect){photosX, photosY, photosSize};
        
        selfHeight = CGRectGetMaxY(self.photosFrame) + FContentOfCellInset * 0.5;
    }
    
    // 工具栏
    if (retweetedStatus.isInComments) {
        CGFloat toolBarY = 0;
        if (retweetedStatus.pic_urls.count) {
            toolBarY = CGRectGetMaxY(self.photosFrame) + FContentOfCellInset * 0.5;
        } else {
            toolBarY = CGRectGetMaxY(self.textFrame) + FContentOfCellInset * 0.5;
        }
        CGFloat toolBarWeight = 200;
        CGFloat toolBarHeight = 35;
        CGFloat toolBarX = FScreenWidth - toolBarWeight;
        self.toolBarFrame = CGRectMake(toolBarX, toolBarY, toolBarWeight, toolBarHeight);
        
        selfHeight = CGRectGetMaxY(self.toolBarFrame) + FContentOfCellInset * 0.5;
    }

    // 总frame
    self.frame = CGRectMake(0, 0, FScreenWidth, selfHeight);
}

@end
