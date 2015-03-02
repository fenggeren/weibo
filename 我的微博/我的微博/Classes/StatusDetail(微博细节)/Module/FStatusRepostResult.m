//
//  FStatusRepostResult.m
//  我的微博
//
//  Created by fenggeren on 15/2/17.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusRepostResult.h"
#import "MJExtension.h"
#import "FStatusRepost.h"

@implementation FStatusRepostResult

- (NSDictionary *)objectClassInArray
{
    return @{@"reposts" : [FStatusRepost class]};
}

@end
