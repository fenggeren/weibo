//
//  FUnreadResult.h
//  我的微博
//
//  Created by fenggeren on 15/2/4.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FBaseParam.h"

@interface FUserUnreadCountResult : FBaseParam

//status	int	新微博未读数

@property (nonatomic, assign) int status;

//follower	int	新粉丝数

@property (nonatomic, assign) int follower;

//cmt	int	新评论数

@property (nonatomic, assign) int cmt;

//dm	int	新私信数

@property (nonatomic, assign) int dm;

//mention_status	int	新提及我的微博数

@property (nonatomic, assign) int mention_status;

//mention_cmt	int	新提及我的评论数
@property (nonatomic, assign) int mention_cmt;


// 消息未读数
@property (nonatomic, assign) int messageCount;

//消息总数
@property (nonatomic, assign) int totalCount;


//group	int	微群消息未读数
//private_group	int	私有微群消息未读数
//notice	int	新通知未读数
//invite	int	新邀请未读数
//badge	int	新勋章数
//photo	int	相册消息未读数

@end
