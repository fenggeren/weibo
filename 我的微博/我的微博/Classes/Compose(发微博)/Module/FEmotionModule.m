//
//  FEmotionModule.m
//  我的微博
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionModule.h"
#import "NSString+Emoji.h"

@implementation FEmotionModule

- (void)setCode:(NSString *)code
{
    _code = [code copy];
    if (!code) return;
    
    self.emoji = [NSString emojiWithStringCode:code];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.cht = [aDecoder decodeObjectForKey:@"cht"];
        self.gif = [aDecoder decodeObjectForKey:@"gif"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.doc = [aDecoder decodeObjectForKey:@"doc"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.cht forKey:@"cht"];
    [aCoder encodeObject:self.gif forKey:@"gif"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.doc forKey:@"doc"];
}

- (BOOL)isEqual:(FEmotionModule *)object
{
    if (self.code) {
        return [self.code isEqualToString:object.code];
    } else {
        return [self.png isEqualToString:object.png] && [self.chs isEqualToString:object.chs] &&[self.cht isEqualToString:object.cht];
    }
}

@end
