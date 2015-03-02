//
//  FAccessTokenParam.h
//  我的微博
//
//  Created by fenggeren on 15/2/2.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAccessTokenParam : NSObject

@property (nonatomic, copy) NSString *cliend_id;

@property (nonatomic, copy) NSString *client_secret;

@property (nonatomic, copy) NSString *grant_type;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *redirect_uri;
@end
