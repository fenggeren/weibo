//
//  FStatusPhotoView.m
//  我的微博
//
//  Created by fenggeren on 15/2/5.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "FPhoto.h"

@interface FStatusPhotoView ()

// gif图片标识
@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation FStatusPhotoView

- (id)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // gif默认没有尺寸
        UIImageView *gif = [[UIImageView alloc] init];
        gif.image = [UIImage imageWithNamed:@"timeline_image_gif"];
        [self addSubview:gif];
        self.gifView = gif;
        
        // gif默认和图片等尺寸
//        UIImageView *gif = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"timeline_image_gif"]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize gifSize = self.gifView.image.size;
    CGFloat gifX = self.width - gifSize.width;
    CGFloat gifY = self.height - gifSize.height;
    self.gifView.frame = (CGRect){gifX, gifY, gifSize};
}

- (void)setPhoto:(FPhoto *)photo
{
    _photo = photo;
    NSString *picName = photo.thumbnail_pic;
    [self setImageWithURL:[NSURL URLWithString:picName] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
    if ([picName hasSuffix:@"gif"]){
        self.gifView.hidden = NO;
    } else {
        self.gifView.hidden = YES;
    }
}


@end
