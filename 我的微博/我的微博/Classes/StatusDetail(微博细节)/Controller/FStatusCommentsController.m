//
//  FStatusDetailController.m
//  我的微博
//
//  Created by fenggeren on 15/2/16.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusCommentsController.h"
#import "FStatus.h"
#import "FUser.h"
#import "FStatusCommentsParam.h"
#import "FStatusCommentsResult.h"
#import "FStatusComment.h"
#import "FStatusTool.h"
#import "FStatusCommentsToolBar.h"
#import "FStatusDetailView.h"
#import "FStatusDetailFrame.h"
#import "FStatusCommentsHeaderToolBar.h"
#import "FStatusRepostResult.h"
#import "FStatusRepostParam.h"
#import "FStatusRepost.h"
@interface FStatusCommentsController () <UITableViewDataSource, UITableViewDelegate, FStatusCommentsHeaderToolBarDelegate>
/** 评论 */
@property (nonatomic, strong) NSMutableArray *comments;

/** 转发 */
@property (nonatomic, strong) NSMutableArray *reposts;

/** 显示评论 */
@property (nonatomic, weak) UITableView *tableView;
/** 工具栏 */
@property (nonatomic, weak) FStatusCommentsToolBar *toolBar;

/** header工具栏 */
@property (nonatomic, strong) FStatusCommentsHeaderToolBar *headerToolBar;
@end

@implementation FStatusCommentsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.status.user.screen_name;
    [self setupTableView];
    [self setupHeader];
    [self setupToolBar];
}

/** 创建header工具栏 */
- (FStatusCommentsHeaderToolBar *)headerToolBar
{
    if (!_headerToolBar) {
        _headerToolBar = [[FStatusCommentsHeaderToolBar alloc] init];
        _headerToolBar.frame = CGRectMake(0, 0, self.view.width, 35);
        _headerToolBar.delegate = self;
        self.headerToolBar.status = self.status;
    }
    return _headerToolBar;
}

/** 创建UITableView */
- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, 0, FScreenWidth, self.view.height - 35);
    tableView.backgroundColor = FTableViewBackgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
/** 创建工具条 */
- (void)setupToolBar
{
    FStatusCommentsToolBar *toolBar = [[FStatusCommentsToolBar alloc] init];
    toolBar.frame = CGRectMake(0, self.tableView.height, FScreenWidth, self.view.height - self.tableView.height);
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}
/** 创建微博显示 */
- (void)setupHeader
{
    FStatusDetailView *detailView = [[FStatusDetailView alloc] init];
    FStatusDetailFrame *detailFrame = [[FStatusDetailFrame alloc] init];
    self.status.retweeted_status.inCommonts = YES;
    detailFrame.status = self.status;
    detailView.detailFrame = detailFrame;
    self.tableView.tableHeaderView = detailView;  
}

- (NSMutableArray *)comments
{
    if (!_comments) {
        _comments = [NSMutableArray array];
    }
    
    return _comments;
}

- (NSMutableArray *)reposts
{
    if (!_reposts) {
        _reposts = [NSMutableArray array];
    }
    
    return _reposts;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.headerToolBar.buttonType == FStatusCommentsHeaderToolBarButtonTypeComment) {
        return self.comments.count;
    } else {  /** if(self.headerToolBar.buttonType == FStatusCommentsHeaderToolBarButtonTypeRepost) */
        return self.reposts.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellID = @"CELLIDD";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    
    NSString *text = nil;
    if (self.headerToolBar.buttonType == FStatusCommentsHeaderToolBarButtonTypeComment) {
        FStatusComment *comment = self.comments[indexPath.row];
        text = comment.text;
    } else {  /** if(self.headerToolBar.buttonType == FStatusCommentsHeaderToolBarButtonTypeRepost) */
        FStatusRepost *repost = self.reposts[indexPath.row];
        text = repost.text;
    }
    cell.textLabel.text = text;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerToolBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headerToolBar.height;
}

#pragma mark --header工具栏代理
- (void)headerToolBarDidSelected:(FStatusCommentsHeaderToolBar *)toolBar buttonType:(FStatusCommentsHeaderToolBarButtonType)buttonType
{   // 点击按钮后， 数据立马更新； 在load方法里加载新的(无论有无)完毕后，再更新
//    [self.tableView reloadData];
    switch (buttonType) {
        case FStatusCommentsHeaderToolBarButtonTypeRepost:
            [self loadReposts];
            break;
            
        case FStatusCommentsHeaderToolBarButtonTypeComment:
            [self loadComments];
            break;
            
        case FStatusCommentsHeaderToolBarButtonTypeAttribute:
            NSLog(@"FStatusCommentsHeaderToolBarButtonTypeRepost");
            
            break;
            
        default:
            break;
    }
}

// 获取 微博评论
- (void)loadComments
{
    FStatusCommentsParam *param = [[FStatusCommentsParam alloc] init];
    param.id = self.status.idstr;
    FStatusComment *comment = [self.comments firstObject];
    if (comment.idstr) { //如果已经有数据，则 设置数组最大id;
        param.since_id = @(comment.idstr.longLongValue);
    }
    
    [FStatusTool statusCommentsWithParam:param success:^(FStatusCommentsResult *result) {
        NSRange range = NSMakeRange(0, result.comments.count);
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
        [self.comments insertObjects:result.comments atIndexes:indexSet];
        [self.tableView reloadData];
        self.status.comments_count = result.total_number;
        self.headerToolBar.status = self.status;
    } failure:^(NSError *error) {
        if (error) {
            FLog(@"%@", error);
        }
    }];
}

- (void)loadReposts
{
    FStatusRepostParam *param = [[FStatusRepostParam alloc] init];
    param.id = self.status.idstr;
    FStatusRepost *repost = [self.reposts firstObject];
    if (repost.idstr) { //如果已经有数据，则 设置数组最大id;
        param.since_id = @(repost.idstr.longLongValue);
    }
    
    [FStatusTool statusRepostsWithParam:param success:^(FStatusRepostResult *result) {
        NSRange range = NSMakeRange(0, result.reposts.count);
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:range];
        [self.reposts insertObjects:result.reposts atIndexes:indexSet];
        [self.tableView reloadData];
        self.status.reposts_count = result.total_number;
        self.headerToolBar.status = self.status;
    } failure:^(NSError *error) {
        if (error) {
            FLog(@"%@", error);
        }
    }];
}


@end














