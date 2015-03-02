//
//  FStatusesComment.h
//  我的微博
//
//  Created by fenggeren on 15/2/16.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

/** 评论数据模型 */
@class FStatus;
#import <Foundation/Foundation.h>

@class FUser;

@interface FStatusComment : NSObject

/** 评论创建时间 */
@property (nonatomic, copy) NSString *created_at;

/**评论的ID */
@property (nonatomic, assign) long long id;

/**评论的内容 */
@property (nonatomic, copy) NSString *text;

/** source	string	评论的来源 */
@property (nonatomic, copy) NSString *source;

/** user	object	评论作者的用户信息字段 详细 */
@property (nonatomic, strong) FUser *user;

/** idstr	string	字符串型的评论ID */
@property (nonatomic, copy) NSString *idstr;
/** status	object	评论的微博信息字段 详细 */
@property (nonatomic, strong) FStatus *status;


/** reply_comment	object	评论来源评论，当本评论属于对另一评论的回复时返回此字段 */
/** mid	string	评论的MID */
@end
