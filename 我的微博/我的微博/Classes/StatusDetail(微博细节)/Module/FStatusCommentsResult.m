//
//  FStatusesDetailResult.m
//  我的微博
//
//  Created by fenggeren on 15/2/16.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusCommentsResult.h"
#import "MJExtension.h"
#import "FStatusComment.h"

@implementation FStatusCommentsResult

- (NSDictionary *)objectClassInArray
{
    return @{@"comments" : [FStatusComment class]};
}

@end
