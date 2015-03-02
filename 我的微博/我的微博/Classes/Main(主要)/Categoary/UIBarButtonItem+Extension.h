//
//  UIBarButtonItem+Extension.h
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)barButtonItemWith:(NSString *)normalName selectedName:(NSString *)selectedName target:(id)target action:(SEL)action;

@end
