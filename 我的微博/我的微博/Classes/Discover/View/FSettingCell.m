//
//  FSettingCell.m
//  我的微博
//
//  Created by fenggeren on 15/2/11.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FSettingCell.h"
#import "FSettingItem.h"
#import "FArrowSettingItem.h"
#import "FSwitchSettingItem.h"
#import "FLabelSettingItem.h"
#import "FSettingBadgeView.h"

@interface FSettingCell ()
/** cell的最右边的accessoryView */
@property (nonatomic, strong) UISwitch *accessorySwitch;
@property (nonatomic, strong) UILabel *accessoryLabel;
/** 三角 90° */
@property (nonatomic, strong) UIImageView *accessoryArrow;

@property (nonatomic, strong) FSettingBadgeView *badgeView;
@end

@implementation FSettingCell

+ (instancetype)settingCellWith:(UITableView *)tableView
{
    static NSString *CellID = @"FSettingCell";
    FSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UISwitch *)accessorySwitch
{
    if (!_accessorySwitch) {
        _accessorySwitch = [[UISwitch alloc] init];
    }
    return _accessorySwitch;
}

- (UILabel *)accessoryLabel
{
    if (!_accessoryLabel) {
        _accessoryLabel = [[UILabel alloc] init];
        _accessoryLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return _accessoryLabel;
}

- (UIImageView *)accessoryArrow
{
    if (!_accessoryArrow) {
        _accessoryArrow = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"common_icon_arrow"]];
    }
    return _accessoryArrow;
}

- (FSettingBadgeView *)badgeView
{
    if (!_badgeView) {
        _badgeView = [[FSettingBadgeView alloc] init];
    }
    return _badgeView;
}

/** 设置cell的背景和选择时背景 */
- (void)setIndexPath:(NSIndexPath *)indexPath numberOfRowsInSection:(NSInteger)rows
{
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selView = (UIImageView *)self.selectedBackgroundView;
    if (rows == 1) { // 如果每部分只有一个cell的
        bgView.image = [UIImage resizedImage:@"common_card_background"];
        selView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    } else if (indexPath.row == 0){ // 每部分第一个cell
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
        selView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    } else if (indexPath.row == rows - 1) { // 每部分 最后一个cell
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
        selView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    } else { // 每部分 中间的cell
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
        
}

- (void)setItem:(FSettingItem *)item
{
    _item = item;
    
    self.imageView.image = [UIImage imageWithNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.detailTitle;
    
    // 最右边 数字提醒
    if (item.badgeValue) {
        [self.badgeView setTitle:item.badgeValue forState:UIControlStateNormal];
        self.accessoryView = self.badgeView;
    } else if ([item isMemberOfClass:[FArrowSettingItem class]]) { // 箭头
        self.accessoryView = self.accessoryArrow;
    } else if ([item isMemberOfClass:[FSwitchSettingItem class]]) { // 开关按钮
        self.accessoryView = self.accessorySwitch;
    } else if ([item isMemberOfClass:[FLabelSettingItem class]]){ //
        FLabelSettingItem *labelItem = (FLabelSettingItem *)item;
        self.accessoryLabel.text = labelItem.label;
        self.accessoryLabel.size = [labelItem.label sizeWithAttributes:@{NSFontAttributeName : self.accessoryLabel.font}];
        self.accessoryView = self.accessoryLabel;
        NSLog(@"%@,%@,%@", self.accessoryView, NSStringFromCGRect(self.accessoryView.frame), self.accessoryLabel.text);
    } else {
        self.accessoryView = nil;
    }
}


/** 调整detailLabel空间的位置，左对齐 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
}

@end




















