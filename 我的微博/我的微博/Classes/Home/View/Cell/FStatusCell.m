//
//  FStatusCell.m
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusCell.h"
#import "FStatusToolBar.h"
#import "FStatusDetailView.h"
#import "FStatusFrame.h"

@interface FStatusCell ()

/** 微博下面的 包含:转发、评论和赞 的工具栏 */
@property (nonatomic, weak) FStatusToolBar *toolbar;

@property (nonatomic, weak) FStatusDetailView *detailView;

@end

@implementation FStatusCell

+ (instancetype)statusCellWith:(UITableView *)tableView
{
    static NSString *CellId = @"CellID-Home";
    FStatusCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellId];
    if (!cell) {
        cell = [[FStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        FStatusDetailView *detailView = [[FStatusDetailView alloc] init];
        [self addSubview:detailView];
        self.detailView = detailView;
//        detailView.backgroundColor = [UIColor redColor];
        FStatusToolBar *toolbar = [[FStatusToolBar alloc] init];
        [self addSubview:toolbar];
        self.toolbar = toolbar;
//        toolbar.backgroundColor = [UIColor yellowColor];
    }
    
    return self;
}

- (void)setStatusFrame:(FStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    self.detailView.detailFrame = statusFrame.detailFrame;
    
    self.toolbar.frame = statusFrame.toobarFrame;
    self.toolbar.status = statusFrame.status;
}

@end
