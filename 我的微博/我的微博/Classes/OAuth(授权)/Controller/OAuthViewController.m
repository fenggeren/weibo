//
//  OAuthViewController.m
//  我的微博
//
//  Created by fenggeren on 15/2/1.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "OAuthViewController.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "FAccount.h"
#import "FAccountTool.h"
#import "FRooterControllerTool.h"
#import "MJExtension.h"
#import "FAccessTokenParam.h"
@interface OAuthViewController () <UIWebViewDelegate>

@end

@implementation OAuthViewController

- (id)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=1760398516&redirect_uri=www.baidu.com"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    webView.delegate = self;
}

// 开始加载前 调用，如果返回YES则加载，否则不加载
// code=35f1532c7d020f8df791bbb51e0a18df
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 获取 将要加载的请求地址
    NSString *url = request.URL.absoluteString;
    
    // 后去授权成功后的请求标记
    /** http://www.baidu.com/?code=35f1532c7d020f8df791bbb51e0a18df  */
    NSRange range = [url rangeOfString:@"http://www.baidu.com/?code="];
    if (range.location != NSNotFound) { // 授权成功
        NSUInteger index = range.location + range.length;
        // 获取 标记
        NSString *code = [url substringFromIndex:index];
        
        // 根据code 获取一个accessToken
        [self accessTokenWithCode:code];
        
        // 获取标记成功，就不用再取加载该地址请求
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在拼命加载中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

// 根据code 获取accessToken
- (void)accessTokenWithCode:(NSString *)code
{
//    FAccessTokenParam *param = [[FAccessTokenParam alloc] init];
//    param.cliend_id = @"1760398516";
//    param.client_secret = @"92b9f89421ba557d72e76b9f326f1de3";;
//    param.grant_type = @"authorization_code";
//    param.code = code;
//    param.redirect_uri = @"www.baidu.com";
//    
//    [FAccountTool accessTokenWithParam:param success:^(FAccount *result) {
//        // 存储账号信息
//        [FAccountTool saveAccount:result];
//        // 选择根控制器-- 是否显示新特性
//        [FRooterControllerTool chooseRooterController];
//    } failure:^(NSError *error) {
//        NSLog(@"%@", error);
//    }];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *url = @"https://api.weibo.com/oauth2/access_token";
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"client_id"] = @"1760398516";
    param[@"client_secret"] = @"92b9f89421ba557d72e76b9f326f1de3";;
    param[@"grant_type"] = @"authorization_code";
    param[@"code"] = code;
    param[@"redirect_uri"] = @"www.baidu.com";
//
    [manager POST:url parameters:param success:^(AFHTTPRequestOperation *operation, NSDictionary *dict) {
//        FAccount *accessToken = [FAccount accountWithDict:dict];
        FAccount *accessToken = [FAccount objectWithKeyValues:dict];
        // 存储账号信息
        [FAccountTool saveAccount:accessToken];
        // 选择根控制器-- 是否显示新特性
        [FRooterControllerTool chooseRooterController];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
