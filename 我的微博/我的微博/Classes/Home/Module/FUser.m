//
//  FUser.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FUser.h"

@implementation FUser

- (BOOL)isVip
{
    return self.mbtype > 2;
}

@end
