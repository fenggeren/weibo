//
//  FStatusRepost.h
//  我的微博
//
//  Created by fenggeren on 15/2/17.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FUser;

@interface FStatusRepost : NSObject


/** 评论创建时间 */
@property (nonatomic, copy) NSString *created_at;

/**字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;

/**评论的内容 */
@property (nonatomic, copy) NSString *text;

/** source	string	评论的来源 */
@property (nonatomic, copy) NSString *source;

/** user	object	评论作者的用户信息字段 详细 */
@property (nonatomic, strong) FUser *user;

/**缩略图片地址 */
@property (nonatomic, copy) NSString *thumbnail_pic;

//
//bmiddle_pic	string	中等尺寸图片地址
//original_pic	string	原始图片地址
//reposts_count	int	转发数
//comments_count	int	评论数
//annotations	array	微博附加注释信息
//
//geo	object	地理信息字段
//retweeted_status	object	转发的微博信息字段

@end
