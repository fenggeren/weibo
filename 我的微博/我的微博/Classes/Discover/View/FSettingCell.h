//
//  FSettingCell.h
//  我的微博
//
//  Created by fenggeren on 15/2/11.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FSettingItem;

@interface FSettingCell : UITableViewCell

+ (instancetype)settingCellWith:(UITableView *)tableView;

/** 传入给定cell的信息：NSIndexPath和每一部分有多少cell */
- (void)setIndexPath:(NSIndexPath *)indexPath numberOfRowsInSection:(NSInteger)rows;

/** cell的数据模型*/
@property (nonatomic, strong) FSettingItem *item;

@end
