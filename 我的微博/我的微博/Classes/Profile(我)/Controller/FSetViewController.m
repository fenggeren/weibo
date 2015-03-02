//
//  FSetViewController.m
//  我的微博
//
//  Created by fenggeren on 15/2/15.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FSetViewController.h"
#import "FArrowSettingItem.h"
#import "FSwitchSettingItem.h"
#import "FLabelSettingItem.h"
#import "FSettingItem.h"
#import "FSettingGroup.h"
#import "FSettingCell.h"

@interface FSetViewController ()

@end

@implementation FSetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupSettingCell];
    [self setupFooter];
}

// 设置离开账号
- (void)setupFooter
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.height = 32;
    
    [button setTitle:@"离开账号" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImage:@"common_card_background"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage resizedImage:@"common_card_background_highlighted"] forState:UIControlStateHighlighted];
    
    
    self.tableView.tableFooterView = button;
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
    
    FArrowSettingItem *item1 = [FArrowSettingItem itemWithTitle:@"设置🏥" icon:@"hot_status" detailTitle:@"笑话，娱乐，神最右都搬到这里了"];
    
    item1.selectedVC = [[[UIViewController alloc] init] class];
    
    group0.items = @[item1];
    
    [self.groups addObject:group0];
}

- (void)setupSettingCell1
{
    FSettingGroup *group1 = [FSettingGroup group];
    
    FArrowSettingItem *item3 = [FArrowSettingItem itemWithTitle:@"应用" icon:@"app"];
    item3.badgeValue = @"3223";
    group1.items = @[item3];
    
    [self.groups addObject:group1];
}

- (void)setupSettingCell2
{
    FSettingGroup *group2 = [FSettingGroup group];
    
    FArrowSettingItem *item1 = [FArrowSettingItem itemWithTitle:@"视频" icon:@"video"];
    FArrowSettingItem *item3 = [FArrowSettingItem itemWithTitle:@"电影" icon:@"movie"];
    group2.items = @[item1,item3];
    
    [self.groups addObject:group2];
}


@end
