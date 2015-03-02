//
//  MeViewController.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "MeViewController.h"
#import "FPopView.h"
#import "FArrowSettingItem.h"
#import "FSwitchSettingItem.h"
#import "FLabelSettingItem.h"
#import "FSettingItem.h"
#import "FSettingGroup.h"
#import "FSettingCell.h"

#import "FSetViewController.h"

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupSettingCell];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(setting)];
}

- (void)setting
{
    FSetViewController *vc = [[FSetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


/** 设置 需要显示的cell数据 */
- (void)setupSettingCell
{
    [self setupSettingCell0];
    [self setupSettingCell1];
    [self setupSettingCell2];
}

- (void)setupSettingCell0
{
    FSettingGroup *group0 = [FSettingGroup group];
    
    FArrowSettingItem *item1 = [FArrowSettingItem itemWithTitle:@"热门微博" icon:@"hot_status" detailTitle:@"笑话，娱乐，神最右都搬到这里了"];
    
    item1.selectedVC = [[[UIViewController alloc] init] class];
    FArrowSettingItem *item2 = [FArrowSettingItem itemWithTitle:@"找人" icon:@"find_people" detailTitle:@"名人、有意思的人尽在这里"];
    item2.operate = ^{
        NSLog(@"FUCK!!");
    };
    group0.items = @[item1, item2];
    
    [self.groups addObject:group0];
}

- (void)setupSettingCell1
{
    FSettingGroup *group1 = [FSettingGroup group];
    
    FLabelSettingItem *item1 = [FLabelSettingItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    item1.label = @"32412394";
    FSwitchSettingItem *item2 = [FSwitchSettingItem itemWithTitle:@"周边" icon:@"near"];
    FArrowSettingItem *item3 = [FArrowSettingItem itemWithTitle:@"应用" icon:@"app"];
    item3.badgeValue = @"3223";
    group1.items = @[item1, item2, item3];
    
    [self.groups addObject:group1];
}

- (void)setupSettingCell2
{
    FSettingGroup *group2 = [FSettingGroup group];
    
    FArrowSettingItem *item1 = [FArrowSettingItem itemWithTitle:@"视频" icon:@"video"];
    FArrowSettingItem *item2 = [FArrowSettingItem itemWithTitle:@"音乐" icon:@"music"];
    FArrowSettingItem *item3 = [FArrowSettingItem itemWithTitle:@"电影" icon:@"movie"];
    FArrowSettingItem *item4 = [FArrowSettingItem itemWithTitle:@"博客" icon:@"cast"];
    FArrowSettingItem *item5 = [FArrowSettingItem itemWithTitle:@"更多" icon:@"more"];
    group2.items = @[item1, item2, item3, item4, item5];
    
    [self.groups addObject:group2];
}


@end
