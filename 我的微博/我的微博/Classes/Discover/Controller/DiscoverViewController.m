//
//  DiscoverViewController.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "DiscoverViewController.h"
#import "FSearchBar.h"
#import "FArrowSettingItem.h"
#import "FSwitchSettingItem.h"
#import "FLabelSettingItem.h"
#import "FSettingItem.h"
#import "FSettingGroup.h"
#import "FSettingCell.h"
#import "MBProgressHUD+MJ.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FSearchBar *bar = [FSearchBar searchBar];
    self.navigationItem.titleView = bar;
    
    [self setupSettingCell];
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
    
    FArrowSettingItem *item1 = [FArrowSettingItem itemWithTitle:@"缓冲" icon:@"video"];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    long long size = [self sizeOfCachedData:path];
    NSString *detailText = [NSString stringWithFormat:@"%.1fM", size / (1000.0 * 1000.0)];
    item1.detailTitle = detailText;
    
    __weak typeof(item1) weakCache = item1;
    __weak typeof(self) weakSelf = self;
    
    item1.operate = ^{
        [MBProgressHUD showMessage:@"正在清理垃圾....."];
        NSFileManager *mgr = [NSFileManager defaultManager];
        [mgr removeItemAtPath:path error:nil];
        weakCache.detailTitle = nil;
        [weakSelf.tableView reloadData];
        [MBProgressHUD hideHUD];
    };
    group2.items = @[item1];
    
    [self.groups addObject:group2];
}


/** 根据路径，返回 文件大小 */
- (long long)sizeOfCachedData:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 路径是否是文件夹
    BOOL isDirectory = NO;
    // 路径是否存在
    BOOL exist = [manager fileExistsAtPath:path isDirectory:&isDirectory];
    
    if (exist == NO) return 0;
    

    if (isDirectory) { // 如果是文件夹，就获取该文件夹内的所有文件
        NSArray *subpaths = [manager contentsOfDirectoryAtPath:path error:nil];
        long long totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullSubpath = [path stringByAppendingPathComponent:subpath];
            totalSize += [self sizeOfCachedData:fullSubpath];
        }
        return totalSize;
    } else {
        NSDictionary *attr = [manager attributesOfItemAtPath:path error:nil];
        return [attr[NSFileSize] longLongValue];
    }
}

@end























