//
//  HomeViewController.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "HomeViewController.h"
#import "FHomeTitleButton.h"
#import "FPopView.h"
#import "AFNetworking.h"
#import "FAccountTool.h"
#import "FAccount.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "FStatus.h"
#import "FUser.h"
#import "MJRefresh.h"

#import "FStatusTool.h"
#import "FHomeStatusesResult.h"
#import "FHomeStatusesParam.h"

#import "FUserTool.h"
#import "FUserInfoResult.h"
#import "FUserInfoParam.h"

#import "FStatusCell.h"
#import "FStatusFrame.h"

#import "FStatusCommentsController.h"


@interface HomeViewController ()

@property (nonatomic, strong) NSMutableArray *statuses;

@property (nonatomic, weak) FHomeTitleButton *titleButton;

@end



@implementation HomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = FTableViewBackgroundColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupNavi];
    
    [self setupRefresh];
    
    // 获取用户信息
    [self userInfo];
    
    // 监听 微博正文 特殊字段被选中发送的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(attributedTextDidSelected:) name:FAttributeTextDidSelectedNotification object:nil];
}

- (void)attributedTextDidSelected:(NSNotification *)noti
{
    NSString *linkText = noti.userInfo[FAttributeTextDidSelectedKey];
    
    if ([linkText hasPrefix:@"http"]) { // 是网址超链接
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
    }else { // 不是http超链接 @ ##
        NSLog(@"%@", linkText);
    }
}

/**
 FUser 和 FAccount 的区别：
 FAccount是账户名，用于登陆该软件
 FUser是一个微博的发表者；
 该方法用于获取用户信息，是一个FUser模型；
 */
- (void)userInfo
{
    FUserInfoParam *param = [[FUserInfoParam alloc] init];
    param.uid = [FAccountTool account].uid;
    
    [FUserTool userInfoWithParam:param success:^(FUserInfoResult *user) {
        
        [self.titleButton setTitle:user.screen_name forState:UIControlStateNormal];
        // 账户的 昵称可以修改， 更新昵称：并存储
        FAccount *account = [FAccountTool account];
        account.screen_name = user.screen_name;
        // 将更新的账户信息 存储
        [FAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        
    }];
}

#pragma 刷新控件处理
// 添加 刷新控件
- (void)setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRefreshing) dateKey:@"table"];
    [self.tableView headerBeginRefreshing];
    
    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    
    self.tableView.headerPullToRefreshText = @"下拉可以刷新";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新";
    self.tableView.headerRefreshingText = @"正在拼命帮你刷新...";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多";
    self.tableView.footerRefreshingText = @"正在拼命帮你加载...";
}

- (void)refreshNewStatuses
{
    // 有刚更新的微博/
    if (self.tabBarItem.badgeValue) {
       self.tableView.contentOffset = CGPointMake(0, -128);
       [self.tableView headerBeginRefreshing];
    }

}

// 下拉更新数据
- (void)headerRefreshing
{
    FHomeStatusesParam *param = [[FHomeStatusesParam alloc] init];
    FStatus *status = [[self.statuses firstObject] status];
    if (status) { //如果已经有数据，则 设置数组最大id;
        param.since_id = @(status.idstr.longLongValue);
    }
    
    [FStatusTool homeStatusesWithParam:param success:^(FHomeStatusesResult *result) {
        NSArray *statuses = result.statuses;
        
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (FStatus *status in statuses) {
            FStatusFrame *statusFrame = [[FStatusFrame alloc] init];
            // 一旦赋值，就会立即计算出，各个控件的frame和显示, 只会计算这一次； 缺陷：随时变化的控件，需要实时更新；如发表时间显示： 刚刚、xx分钟前， 实时计算器frame，不然显示不正确；
            statusFrame.status = status;
            [arrayM addObject:statusFrame];
        }
        // 将新数据 插入到模型数组中
        NSRange range = NSMakeRange(0, arrayM.count);
        NSIndexSet *set = [[NSIndexSet alloc] initWithIndexesInRange:range];
        [self.statuses insertObjects:arrayM atIndexes:set];
        
        // 更新完数据， 应该将 显示的需更新数量 清零隐藏/
        self.tabBarItem.badgeValue = nil;
        // 移除更新按钮
        [self.tableView headerEndRefreshing];
        // 更新显示数据
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        // 移除更新按钮
        [self.tableView headerEndRefreshing];
    }];
    
}
// 上拉 加载数据
- (void)footerRefreshing
{
    
    FHomeStatusesParam *param = [[FHomeStatusesParam alloc] init];
//    param.access_token = [FAccountTool account].access_token;

    FStatus *status = [[self.statuses lastObject] status];
    if (status) { //如果已经有数据，则 设置数组最大id;
        param.max_id = @(status.idstr.longLongValue - 1);
    }

    [FStatusTool homeStatusesWithParam:param success:^(FHomeStatusesResult *result) {
     
        NSArray *statuses = result.statuses;
        // 转换为FStatusFrame并添加到arrayM里
        NSMutableArray *arrayM = [NSMutableArray array];
        for (FStatus *status in statuses) {
            FStatusFrame *statusFrame = [[FStatusFrame alloc] init];
            // 一旦赋值，就会立即计算出，各个控件的frame和显示
            statusFrame.status = status;
            [arrayM addObject:statusFrame];
        }

        [self.statuses addObjectsFromArray:arrayM];
        // 移除更新按钮
        [self.tableView footerEndRefreshing];
        // 更新显示数据
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        // 移除更新按钮
        [self.tableView footerEndRefreshing];
    }];
}


- (NSMutableArray *)statuses
{
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    
    return _statuses;
}

// 设置导航栏 按钮和 标题
- (void)setupNavi
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWith:@"navigationbar_pop" selectedName:@"navigationbar_pop_highlighted" target:self action:@selector(scanle)];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWith:@"navigationbar_friendsearch" selectedName:@"navigationbar_friendsearch_highlighted" target:self action:@selector(addFriend)];
    
    FHomeTitleButton *button = [FHomeTitleButton buttonWithType:UIButtonTypeCustom];
    button.height = 30;
    [button setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    NSString *name = [FAccountTool account].screen_name;
    [button setTitle:name ? name : @"首页" forState:UIControlStateNormal];

    [button addTarget:self action:@selector(firstPage:) forControlEvents:UIControlEventTouchUpInside];
//    button.width = button.titleLabel.width + button.height;
    self.navigationItem.titleView = button;
    
    self.titleButton = button;
}


- (void)firstPage:(UIButton *)button
{
    [button setImage:[UIImage imageWithNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    
    UIButton *showB = [UIButton buttonWithType:UIButtonTypeContactAdd];
    showB.backgroundColor = [UIColor redColor];
    showB.frame = CGRectMake(0, 0, 80, 80);
    FPopView *pop = [FPopView popWithView:showB];
    
    __weak typeof(button) btn = button;
    pop.dismissBlock = ^{
        [btn setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    };
    [pop showInRect:CGRectMake(100, 100, 300, showB.height)];
}

- (void)scanle
{
        NSLog(@"%@", NSStringFromCGRect(self.tableView.frame));
}

- (void)addFriend
{
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statuses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FStatusCell *cell = [FStatusCell statusCellWith:tableView];
    
    cell.statusFrame = self.statuses[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statuses[indexPath.row] cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FStatusCommentsController *tabVc = [[FStatusCommentsController alloc] init];
    tabVc.status = [self.statuses[indexPath.row] status];
    [self.navigationController pushViewController:tabVc animated:YES];
}

    
    
@end
