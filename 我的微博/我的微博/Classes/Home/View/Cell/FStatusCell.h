//
//  FStatusCell.h
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FStatusFrame;

@interface FStatusCell : UITableViewCell

+ (instancetype)statusCellWith:(UITableView *)tableView;

@property (nonatomic, strong) FStatusFrame *statusFrame;

@end
