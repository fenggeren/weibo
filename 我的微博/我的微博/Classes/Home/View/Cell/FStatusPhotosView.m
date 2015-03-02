//
//  FStatusPhotosView.m
//  我的微博
//
//  Created by fenggeren on 15/2/5.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusPhotosView.h"
#import "FStatusPhotoView.h"
#import "FStatus.h"
#import "FPhoto.h"
#import "UIImageView+WebCache.h"

#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define FPhotoWidth 76
#define FPhotoHeight FPhotoWidth
#define FPhotosMargin 10
#define FMaxRows 3

@interface FStatusPhotosView ()

/** 用于存放 */
@property (nonatomic, strong) NSMutableArray *photos;

/** 图片的原始frame */
@property (nonatomic, assign) CGRect imageFrame;

/** 在遮盖上用于显示的 图片view */
@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation FStatusPhotosView

- (id)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    
    return _photos;
}

- (void)setStatus:(FStatus *)status
{
    _status = status;
    
    NSArray *photos = status.pic_urls;
    
    for (NSInteger i = 0; i < photos.count; ++i) {
        FStatusPhotoView *photo = nil;
        if (i < self.photos.count) {
            photo = self.photos[i];
        } else {
            photo = [[FStatusPhotoView alloc] init];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
            [photo addGestureRecognizer:tap];
            [self addSubview:photo];
            [self.photos addObject:photo];
        }
        photo.tag = i;
        photo.photo = photos[i];
        photo.hidden = NO;
    }

    for (NSInteger i = 0; i > photos.count; ++i) {
        [self.photos[i] setHidden:YES];
    }
    
//    [self layoutIfNeeded];
}

-(void)handleGesture:(UIGestureRecognizer*)gestureRecognizer
{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    NSMutableArray *photos = [NSMutableArray array];
    NSInteger count = self.photos.count;
    for (NSInteger i = 0; i < count; ++i) {
        FPhoto *pic = [self.photos[i] photo];
    
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    
    browser.photos = photos;
    
    browser.currentPhotoIndex = gestureRecognizer.view.tag;
    
    [browser show];
}


//-(void)handleGesture:(UIGestureRecognizer*)gestureRecognizer
//{
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    // 遮盖
//    UIView *cover = [[UIView alloc] init];
//    cover.frame = window.bounds;
//    [window addSubview:cover];
//    cover.backgroundColor = [UIColor blackColor];
//    cover.alpha = 0.3;
//    
//    // 给遮盖添加手势，以便 点击时 移除
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeCover:)];
//    [cover addGestureRecognizer:tap];
//    
//    FStatusPhotoView *photo = (FStatusPhotoView *)gestureRecognizer.view;
//
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [imageView setImageWithURL:[NSURL URLWithString:photo.photo.bmiddle_pic] placeholderImage:photo.image];
//    // 转换坐标
//    self.imageFrame = photo.frame;
//    imageView.frame = [self convertRect:photo.frame toView:cover];
//    [cover addSubview:imageView];
//    self.imageView = imageView;
//    [UIView animateWithDuration:0.2 animations:^{
//        cover.alpha = 1.0;
//        CGRect frame = imageView.frame;
//        frame.size = CGSizeMake(cover.width, photo.height * cover.width / photo.width);
//        imageView.frame = frame;
//        imageView.center = CGPointMake(cover.width * 0.5, cover.height * 0.5);
//    }];
//}
//
//// 点击遮盖，图片回到原来位置， 遮盖消失
//- (void)removeCover:(UITapGestureRecognizer *)recognizer
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        self.imageView.frame = self.imageFrame;
//        recognizer.view.alpha = 0.0;
//    } completion:^(BOOL finished) {
//        [recognizer.view removeFromSuperview];
//        self.imageView = nil;
//    }];
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.status.pic_urls.count;
    //特殊情况 如果是4张图片，则为田字形
    NSInteger maxCols = count == 4 ? 2 : FMaxRows;
    
    for (NSInteger i = 0; i < self.subviews.count; ++i){
        FStatusPhotoView *photo = self.subviews[i];
        if (photo.hidden == NO) {
            CGFloat x = (FPhotoWidth + FPhotosMargin) * (i % maxCols);
            CGFloat y = (FPhotosMargin + FPhotoHeight) * (i / maxCols);
            photo.frame = CGRectMake(x, y, FPhotoWidth, FPhotoHeight);
        }
    }
}


+ (CGSize)sizeWithCount:(NSInteger)count
{
    // 单张图片尺寸
//    CGFloat photoW = 76;
//    CGFloat photoH = photoW;
//    CGFloat photoMargin = 10; // 图片间距
    
    // 最大列数 3
    
    //特殊情况 如果是4张图片，则为田字形
    NSInteger maxCols = count == 4 ? 2 : FMaxRows;
    
    NSInteger cols = count > maxCols ? maxCols : count;
    NSInteger rows = (count + (maxCols - 1)) / maxCols;
    
    CGFloat photosWidth = FPhotoWidth * cols + (cols - 1) * FPhotosMargin;
    CGFloat photosHeight = FPhotoHeight * rows + (rows - 1) * FPhotosMargin;

    return CGSizeMake(photosWidth, photosHeight);
}

@end
