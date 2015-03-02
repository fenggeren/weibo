//
//  FStatusOriginalView.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusOriginalView.h"
#import "FStatusOriginalFrame.h"
#import "FStatus.h"
#import "FUser.h"
#import "UIImageView+WebCache.h"
#import "FStatusPhotosView.h"
#import "FStatusLabel.h"
@interface FStatusOriginalView ()

/** toux */
@property (nonatomic, weak) UIImageView *iconView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 发表时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) FStatusLabel *textLabel;
/** 会员标识 */
@property (nonatomic, weak) UIImageView *vipView;

/** 图片集 */
@property (nonatomic, weak) FStatusPhotosView *photosView;

@end

@implementation FStatusOriginalView

- (id)init
{
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        /** 创建子控件 */
        
        // 头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = FTimeOfStatusFont;
        timeLabel.textColor = [UIColor orangeColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = FNameOfStatusFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = FSourceOfStatusFont;
        sourceLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 正文
        FStatusLabel *textLabel = [[FStatusLabel alloc] init];
//        textLabel.font = FTextOfStatusFont;
//        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // vip图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter; // 中间显示
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 图片集
        FStatusPhotosView *photosView = [[FStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    
    return self;
}

- (void)setOriginalFrame:(FStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    FStatus *status = originalFrame.status;
    FUser *user = status.user;
    
    // 设置头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithNamed:@"avatar_default"]];
    self.iconView.frame = originalFrame.iconFrame;
    
    // 设置昵称
    self.nameLabel.text = user.screen_name;
    self.nameLabel.frame = originalFrame.nameFrame;

    // 设置vip
    if (user.isVip) { // 是vip
        self.vipView.frame = originalFrame.vipFrame;
        NSString *name = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageWithNamed:name];
        self.nameLabel.textColor = [UIColor redColor];
        self.vipView.hidden = NO;
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    // 设置时间, 因为时间显示会变化，所以其frame需要实时更新
    self.timeLabel.text = status.created_at;
    CGFloat timeX = self.nameLabel.x;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + FContentOfCellInset * 0.5;
    CGSize timeSize = [status.created_at sizeWithAttributes:@{NSFontAttributeName : FTimeOfStatusFont}];
    self.timeLabel.frame = (CGRect){timeX, timeY, timeSize};
    
    //设置来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + FContentOfCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithAttributes:@{NSFontAttributeName : FSourceOfStatusFont}];
    self.sourceLabel.frame = (CGRect){sourceX, sourceY, sourceSize};
    
    // 设置正文
    self.textLabel.attributedText = status.attributedString;
    self.textLabel.frame = originalFrame.textFrame;
    
    // 图片集
    if (status.pic_urls.count) {
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.status = status;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
   
    
    self.frame = originalFrame.frame;
}

@end















