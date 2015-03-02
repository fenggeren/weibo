//
//  FEmotionListView.m
//  我的微博
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionListView.h"
#import "FEmotionGridView.h"

@interface FEmotionListView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIPageControl *pageControl;

/** 用于显示一页表情的view的数组 */
@property (nonatomic, strong) NSMutableArray *gridViews;

@end

@implementation FEmotionListView


- (id)init
{
    if (self = [super init]) {
        [self setupScrollView];
        [self setupPageControl];
    }
    
    return self;
}

- (NSMutableArray *)gridViews
{
    if (!_gridViews) {
        _gridViews = [NSMutableArray array];
    }
    return _gridViews;
}

- (void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    scrollView.delegate = self;
}

// scroll代理方法： 拖拽是调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / scrollView.width + 0.5);
}

- (void)setupPageControl
{
    UIPageControl *pages = [[UIPageControl alloc] init];
    [self addSubview:pages];
    self.pageControl = pages;
    [pages setValue:[UIImage imageWithNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
    [pages setValue:[UIImage imageWithNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    // 需要显示的页数
    NSInteger pages = (emotions.count + kEmotionMaxCountPerPage - 1) / kEmotionMaxCountPerPage;
    self.pageControl.numberOfPages = pages;
    self.pageControl.currentPage = 0;
    self.scrollView.contentOffset = CGPointZero;
    // gridView不够创建，多余隐藏；
    for (NSInteger i = 0; i < pages; ++i) {
        FEmotionGridView *gridView = nil;
        if (i < self.gridViews.count) {
            gridView = self.gridViews[i];
        } else {
            gridView = [[FEmotionGridView alloc] init];
            [self.scrollView addSubview:gridView];
            [self.gridViews addObject:gridView];
        }
        NSUInteger loc = i * kEmotionMaxCountPerPage;
        NSUInteger len = (loc + kEmotionMaxCountPerPage) > emotions.count ? (emotions.count - loc) : kEmotionMaxCountPerPage;
        NSRange range = NSMakeRange(loc, len);
        // 获取该页需显示的表情 范围
        NSArray *array = [self.emotions subarrayWithRange:range];
        gridView.emotions = array;
        gridView.hidden = NO;
    }
    
    // 为了重复利用， 需要设置hidden
    for (NSInteger i = pages; i < self.gridViews.count; ++i) {
        [self.gridViews[i] setHidden:YES];
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.pageControl.height = 35;
    self.pageControl.y = self.height - self.pageControl.height;
    self.pageControl.x = 0;
    self.pageControl.width = self.width;

    self.scrollView.height = self.pageControl.y;
    self.scrollView.width = self.width;
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    
    self.scrollView.contentSize = CGSizeMake(self.width * self.pageControl.numberOfPages, 0);
    for (NSInteger i = 0; i < self.gridViews.count; ++i) {
        FEmotionGridView *view = self.gridViews[i];
        if (view.hidden) break;
        view.frame = CGRectMake(self.scrollView.width * i, 0, self.scrollView.width, self.scrollView.height);
    }
    
}


@end
























