//
//  FStatusDetailController.h
//  我的微博
//
//  Created by fenggeren on 15/2/16.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FStatus;
/** 
 继承自UIViewController而不是UITableViewController是因为 该界面最下面有一个 始终显示的工具栏； 所以需要再创建一个UITableView添加到该 控制器上， 创建一个工具栏添加上。。
 */
@interface FStatusCommentsController : UIViewController

@property (nonatomic, strong) FStatus *status;

@end
