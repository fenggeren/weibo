//
//  FStatusLink.m
//  我的微博
//
//  Created by fenggeren on 15/2/10.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusLink.h"

@implementation FStatusLink

- (void)setRects:(NSArray *)rects
{
    NSMutableArray *array = [NSMutableArray array];
    for (UITextSelectionRect *rect in rects) {
        if (rect.rect.size.width > 0) {
            [array addObject:rect];
        }
    }
    
    _rects = array;
}

@end
