//
//  MsgViewController.m
//  Weibo
//
//  Created by fenggeren on 15/1/19.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "MsgViewController.h"

@implementation MsgViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写信息" style:UIBarButtonItemStyleDone target:self action:@selector(writeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)writeMsg
{
    
}

@end
