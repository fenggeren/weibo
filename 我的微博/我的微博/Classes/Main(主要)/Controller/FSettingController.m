//
//  FSettingController.m
//  我的微博
//
//  Created by fenggeren on 15/2/15.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FSettingController.h"
#import "FSettingItem.h"
#import "FSettingGroup.h"
#import "FSettingCell.h"

@interface FSettingController ()

@end

@implementation FSettingController

- (id)init
{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = FTableViewBackgroundColor;
    self.tableView.sectionFooterHeight = FCellMargin;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSettingCell *cell = [FSettingCell settingCellWith:tableView];
    FSettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    [cell setIndexPath:indexPath numberOfRowsInSection:group.items.count];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FSettingGroup *group = self.groups[indexPath.section];
    FSettingItem *item = group.items[indexPath.row];
    if (item.selectedVC) {
        UIViewController *vc = [[item.selectedVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if(item.operate) {
        item.operate();
    }
}@end
