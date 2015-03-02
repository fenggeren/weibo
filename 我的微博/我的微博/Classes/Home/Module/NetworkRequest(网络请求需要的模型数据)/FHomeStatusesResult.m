//
//  FHomeStatusesResult.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FHomeStatusesResult.h"
#import "FStatus.h"
#import "MJExtension.h"

@implementation FHomeStatusesResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [FStatus class]};
}

@end
