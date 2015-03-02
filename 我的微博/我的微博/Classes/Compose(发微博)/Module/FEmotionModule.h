//
//  FEmotionModule.h
//  我的微博
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FEmotionModule : NSObject <NSCoding>

// 简体说明
@property (nonatomic, copy) NSString *chs;
// 繁体说明
@property (nonatomic, copy) NSString *cht;
// gif图片
@property (nonatomic, copy) NSString *gif;

// png图片
@property (nonatomic, copy) NSString *png;

// emoji图片的二进制格式
@property (nonatomic, copy) NSString *code;

// 图片所在目录
@property (nonatomic, copy) NSString *doc;

/** emoji表情代码，直接用 */
@property (nonatomic, copy) NSString *emoji;

@end
