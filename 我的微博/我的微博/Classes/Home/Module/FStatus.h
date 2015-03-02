//
//  FStatus.h
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//
//favorited	boolean	是否已收藏，true：是，false：否
//truncated	boolean	是否被截断，true：是，false：否
//in_reply_to_status_id	string	（暂未支持）回复ID
//in_reply_to_user_id	string	（暂未支持）回复人UID
//in_reply_to_screen_name	string	（暂未支持）回复人昵称
//bmiddle_pic	string	中等尺寸图片地址，没有时不返回此字段
//original_pic	string	原始图片地址，没有时不返回此字段
//geo	object	地理信息字段 详细
//visible	object	微博的可见性及指定可见分组信息。该object中type取值，0：普通微博，1：私密微博，3：指定分组微博，4：密友微博；list_id为分组的组号
//ad	object array	微博流内的推广微博ID



/** 一条微博模型 */

#import <Foundation/Foundation.h>

@class FUser;

@interface FStatus : NSObject

/** string	微博创建时间 */
@property (nonatomic, copy) NSString *created_at;

//id	int64	微博ID
//mid	int64	微博MID

//@property (nonatomic, copy) NSString *ID;

/** idstr	string	字符串型的微博ID */
@property (nonatomic, copy) NSString *idstr;

/**text	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/** 用于显示的富文本 */
@property (nonatomic, copy) NSAttributedString *attributedString;

/** source	string	微博来源 */
@property (nonatomic, copy) NSString *source;

/** thumbnail_pic	string	缩略图片地址，没有时不返回此字段 */
//@property (nonatomic, copy) NSString *thumbnail_pic;

/** reposts_count	int	转发数 */
@property (nonatomic, assign) NSNumber *reposts_count;

/** comments_count	int	评论数 */
@property (nonatomic, assign) NSNumber *comments_count;

/** int	表态数 */
@property (nonatomic, assign) NSNumber *attitudes_count;

/** object	微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url。 */
@property (nonatomic, strong) NSArray *pic_urls;

/** object	微博作者的用户信息字段 详细 */
@property (nonatomic, strong) FUser *user;

/** object	被转发的原微博信息字段，当该微博为转发微博时返回 详细 */
@property (nonatomic, strong) FStatus *retweeted_status;

/** 是否是评论控制器中的微博 */
@property (nonatomic, assign, getter = isInComments) BOOL inCommonts;

@end
