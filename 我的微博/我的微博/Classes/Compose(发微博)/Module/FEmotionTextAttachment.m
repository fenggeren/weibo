//
//  FEmotionTextAttachment.m
//  我的微博
//
//  Created by fenggeren on 15/2/9.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionTextAttachment.h"
#import "FEmotionModule.h"

@implementation FEmotionTextAttachment

- (void)setEmotion:(FEmotionModule *)emotion
{
    _emotion = emotion;
   
    NSString *imageName = [NSString stringWithFormat:@"%@/%@",emotion.doc, emotion.png];
    self.image = [UIImage imageNamed:imageName];
}

@end
