//
//  FAccessToken.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FAccount.h"

@implementation FAccount

//+ (instancetype)accountWithDict:(NSDictionary *)dict
//{
//    FAccount *token = [[self alloc] init];
//    token.uid = dict[@"uid"];
//    token.access_token = dict[@"access_token"];
//    token.expires_in = dict[@"expires_in"];
//    
//    return token;
//}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = expires_in;
    
    NSDate *date = [NSDate date];
    // 现在的时间 + 授权时间 得出过期时间
    self.expires_time = [date dateByAddingTimeInterval:self.expires_in.doubleValue];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.screen_name = [aDecoder decodeObjectForKey:@"screen_name"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.screen_name forKey:@"screen_name"];
}

@end
