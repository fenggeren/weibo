//
//  FBaseParam.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FBaseParam.h"
#import "FAccountTool.h"
#import "FAccount.h"

@implementation FBaseParam

- (id)init
{
    if (self = [super init]) {
        _access_token = [FAccountTool account].access_token;
    }
    
    return self;
}

@end
