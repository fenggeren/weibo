//
//  FStatusOriginalFrame.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusOriginalFrame.h"
#import "FStatus.h"
#import "FUser.h"
#import "FStatusPhotosView.h"

@implementation FStatusOriginalFrame

// 在这里计算各个frame，而不是在init内，因为有的空间的frame需要数据：如昵称和正文需要知道
- (void)setStatus:(FStatus *)status
{
    _status = status;
    
    // 头像
    CGFloat iconWidth = 35;
    CGFloat iconHeight = iconWidth;
    CGFloat iconX = FContentOfCellInset;
    CGFloat iconY = FContentOfCellInset;
    self.iconFrame = CGRectMake(iconX, iconY, iconWidth, iconHeight);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + FContentOfCellInset;
    CGFloat nameY = FContentOfCellInset;
    CGSize nameSize = [self.status.user.screen_name sizeWithAttributes:@{NSFontAttributeName : FNameOfStatusFont}];
    self.nameFrame = (CGRect){nameX, nameY, nameSize};
    
    // vip
    CGFloat vipX = CGRectGetMaxX(self.nameFrame) + FContentOfCellInset * 0.5;
    CGFloat vipY = nameY;
    CGFloat vipWidth = 14;
    CGFloat vipHeight = 14;
    self.vipFrame = CGRectMake(vipX, vipY, vipWidth, vipHeight);
    // 正文
    CGFloat textX = FContentOfCellInset;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + FContentOfCellInset;
    CGSize textMaxSize = CGSizeMake(FScreenWidth - 2 * FContentOfCellInset, CGFLOAT_MAX);
    CGSize textSize = [self.status.attributedString boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//    CGSize textSize = [self.status.text sizeWithFont:FTextOfStatusFont constrainedToSize:textMaxSize];
    self.textFrame = (CGRect){textX, textY, textSize};
    
    CGFloat selfHeight = 0;
    // 图片集
    if (status.pic_urls.count) {
        CGSize photosSize = [FStatusPhotosView sizeWithCount:status.pic_urls.count];
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + FContentOfCellInset;
        self.photosFrame = (CGRect){photosX, photosY, photosSize};
        
        selfHeight = CGRectGetMaxY(self.photosFrame) + FContentOfCellInset;
    } else {
        selfHeight = CGRectGetMaxY(self.textFrame) + FContentOfCellInset;
    }
    CGFloat selfWidth = FScreenWidth;
    self.frame = CGRectMake(0, 0, selfWidth, selfHeight);
}

    /** 时间显示，随着时间变化，显示不同； 需要实时更新，不应在这里做 恒定计算 */
//    // 时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + FContentOfCellInset * 0.5;
//    CGSize timeSize = [self.status.created_at sizeWithAttributes:@{NSFontAttributeName : FTimeOfStatusFont}];
//    self.timeFrame = (CGRect){timeX, timeY, timeSize};
//    
//    // 来源
//    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + FContentOfCellInset;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [self.status.source sizeWithAttributes:@{NSFontAttributeName : FSourceOfStatusFont}];
//    self.sourceFrame = (CGRect){sourceX, sourceY, sourceSize};
@end
























