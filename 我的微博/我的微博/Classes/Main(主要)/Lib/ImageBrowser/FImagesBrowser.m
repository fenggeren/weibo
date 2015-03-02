//
//  FImagesBrowser.m
//  我的微博
//
//  Created by fenggeren on 15/2/6.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FImagesBrowser.h"
#import "FImage.h"
#import "UIImageView+WebCache.h"

@interface FImagesBrowser () <UIScrollViewDelegate>

/** 用于显示图片的 */
@property (nonatomic, weak) UIScrollView *scrollView;

/** 用于显示图片下标 */
@property (nonatomic, weak) UILabel *indexLabel;

@end

@implementation FImagesBrowser

- (id)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    UILabel *label = [[UILabel alloc] init];
    label.size = CGSizeMake(self.view.width, self.view.height * 0.1);
    label.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.8);
    label.textAlignment = NSTextAlignmentCenter;
    label.contentMode = UIViewContentModeCenter;
    [self.view addSubview:label];
    self.indexLabel = label;
}


- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window.rootViewController addChildViewController:self];
    
    FImage *image = self.images[self.curIndex];
    [self.view convertRect:image.oriFrame fromView:self.view];
}

- (void)setImages:(NSArray *)images
{
    _images = images;
    
    self.scrollView.contentSize = CGSizeMake(self.view.width * images.count, self.view.height);
    for (NSInteger i = 0; i < images.count; ++i) {
        UIImageView *view = [[UIImageView alloc] init];
        view.contentMode = UIViewContentModeScaleAspectFit;
        view.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.5);
        view.width = self.view.width;
        view.height = self.view.height;
        FImage *image = images[i];
        [view setImageWithURL:[NSURL URLWithString:image.url] placeholderImage:image.image];
        [self.scrollView addSubview:view];
    }
}

// 代理--- 滑动scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.curIndex = (scrollView.contentOffset.x / scrollView.width) + 0.5;
    self.indexLabel.text = [NSString stringWithFormat:@"%zd / %zd", self.curIndex, self.images.count];
    
}

@end






































