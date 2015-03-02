//
//  ComposeViewController.m
//  Weibo
//
//  Created by fenggeren on 15/1/21.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "ComposeViewController.h"

#import "FComposeTextView.h"
#import "FEmotionTextView.h"
#import "FKeyboardToolBar.h"
#import "FComposePhotosView.h"
#import "FEmotionKeyboard.h"
#import "AFNetworking.h"
#import "FAccountTool.h"
#import "FAccount.h"
#import "MBProgressHUD+MJ.h"

#import "FStatusTool.h"
#import "FSendStatusParam.h"
#import "FSendStatusResult.h"
#import "FEmotionModule.h"

@interface ComposeViewController () <FComposeTextViewDelegate, FKeyboardToolBarDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UITextViewDelegate>

@property (nonatomic, weak) FEmotionTextView *textView;

@property (nonatomic, weak) FKeyboardToolBar *keyboardToolBar;

@property (nonatomic, weak) FComposePhotosView *photosView;

@property (nonatomic, strong) FEmotionKeyboard *emotionKeyboard;

/** 是否在切换键盘 */
@property (nonatomic, assign, getter = isSwitchKeyboard) BOOL switchKeyboard;

@end

@implementation ComposeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置导航栏上 按钮
    [self setupNavigationButton];
    
    // 设置输入控件
    [self setupTextField];
    // 设置图片显示容器
    [self setupPhotosView];
    
    // 设置键盘上的工具栏
    [self setupKeyboardToolBar];

    // 监听 增加 表情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelected:) name:FEmotionDidSelectedNotification object:nil];
    
    // 监听删除 表情
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteEmotion:) name:FEmotionDidDeleteNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.textView becomeFirstResponder];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark 写入表情
/** 因为是拼接的富文本，直接赋值，所以不会被监听到UITextViewTextDidChangeNotification的方法，应该重写- (void)setAttributedText:(NSAttributedString *)attributedText方法，显示调用监听方法 */
- (void)emotionDidSelected:(NSNotification *)noti
{
    FEmotionModule *module = noti.userInfo[FEmotionDidSelectedKey];
 
    [self.textView insertEmotion:module];
}

/** 删除表情 */
- (void)deleteEmotion:(NSNotification *)noti
{
    [self.textView deleteBackward];
}

- (FEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        _emotionKeyboard = [[FEmotionKeyboard alloc] init];
        _emotionKeyboard.size = CGSizeMake(320, 216);
    }
    return _emotionKeyboard;
}

// 设置图片容器
- (void)setupPhotosView
{
    FComposePhotosView *photos = [[FComposePhotosView alloc] init];
    photos.size = self.textView.size;
    photos.y = 100;
    [self.textView addSubview:photos];
    
    self.photosView = photos;
}

//////////////////////////////////////设置导航栏按钮////////////////////////////////////////////////////
- (void)setupNavigationButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(composeCancle)];


    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(transmit)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [FAccountTool account].screen_name;
    if (name) { // 有昵称
        // 要显示的文字
        NSString *prefix = @"发微博";
        NSString *text = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        // 两部分字体大小不同
        UIFont *prefixFont = [UIFont systemFontOfSize:15];
        UIFont *nameFont = [UIFont systemFontOfSize:12];
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
        [string addAttribute:NSFontAttributeName value:prefixFont range:[text rangeOfString:prefix]];
        [string addAttribute:NSFontAttributeName value:nameFont range:[text rangeOfString:name]];
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        CGSize prefixSize = [prefix sizeWithAttributes:@{NSFontAttributeName : prefixFont}];
        CGSize nameSize = [name sizeWithAttributes:@{NSFontAttributeName : nameFont}];
        // 设置label的size；两部分size相加
        label.width = prefixSize.width > nameSize.width ? prefixSize.width : nameSize.width;
        label.height = prefixSize.height + nameSize.height;
        label.attributedText = string;
        self.navigationItem.titleView = label;
    } else {
        self.title = @"发微博";
    }
}

- (void)composeCancle
{
    [self.textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 发微博
- (void)transmit
{
    if (self.photosView.images.count) { // 有图片
        [self transmitHavePic];
    } else {
        [self transmitOnlyText];
    }
}

// 发送只有文字的微博
- (void)transmitOnlyText
{
    FSendStatusParam *param = [[FSendStatusParam alloc] init];
    param.status = self.textView.attributedString;
    
    [FStatusTool sendStatusesWithParam:param success:^(FSendStatusResult *result) {
        [MBProgressHUD showSuccess:@"发表成功"];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"发表失败"];
    }];
    
    // 发送信息 可能会耗时， 所以异步发送信息，这里退回主目录
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 发送 带图片的微博
- (void)transmitHavePic
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    NSString *url = @"https://upload.api.weibo.com/2/statuses/upload.json";
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"access_token"] = [FAccountTool account].access_token;
    param[@"status"] = self.textView.text;
    
    [mgr POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    
        // 面向对象-- 封装性， 直接获取图片集
        NSArray *array = [self.photosView images];
        // 开放的接口只能发送一张图片.
        NSData *data = UIImageJPEGRepresentation([array lastObject], 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"image.jpg" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

///////////////////////////////////////设置输入控件TextField///////////////////////////////////////////////////
- (void)setupTextField
{
    FEmotionTextView *textView = [[FEmotionTextView alloc] init];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    
    textView.placeholder = @"请输入微博内容";
    textView.font = [UIFont systemFontOfSize:20];
    textView.delegate = self;
    textView.delegateCompose = self;
    // 允许向下拉
    textView.alwaysBounceVertical = YES;
    self.textView = textView;

    // 监听 键盘出现和退出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

// 键盘即将弹起
- (void)keyboardWillShow:(NSNotification *)note
{
    // 键盘弹起动画用时
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.keyboardToolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardFrame.size.height);
    }];
}

// 键盘退出时 调用
- (void)keyboardWillHide:(NSNotification *)note
{
    if (self.isSwitchKeyboard) { // 系统键盘和表情键盘互相切换时，键盘工具栏不动作
        self.switchKeyboard = NO;
        return;
    }
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.keyboardToolBar.transform = CGAffineTransformIdentity;
    }];
}

// 输入显示控件代理， 同步发送enable按钮
- (void)composeTextViewDidEnable:(FComposeTextView *)textView enableSend:(BOOL)enable
{
    self.navigationItem.rightBarButtonItem.enabled = enable;
}

// 拖拽完-- 退出键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.textView resignFirstResponder];
}

/////////////////////////////////////////设置键盘上面的工具栏/////////////////////////////////////////////////
- (void)setupKeyboardToolBar
{
    FKeyboardToolBar *toolBar = [[FKeyboardToolBar alloc] init];
    toolBar.width = self.textView.width;
    toolBar.height = 44;
    toolBar.x = 0;
    toolBar.y = self.view.height - toolBar.height;
    self.keyboardToolBar = toolBar;
    [self.view addSubview:toolBar];
    toolBar.delegate = self;
}

- (void)keyboardToolBarDidClick:(FKeyboardToolBar *)toolBar withType:(FKeyboardToolBarButtonType)type
{
    switch (type) {
        case FKeyboardToolBarButtonTypeCamera:
            [self keyboardToolBarWithCameraType];
            break;
            
        case FKeyboardToolBarButtonTypePicture:
            [self keyboardToolBarWithPictureType];
            break;
            
        case FKeyboardToolBarButtonTypeTrend:
            [self keyboardToolBarWithTrendType];
            break;
            
        case FKeyboardToolBarButtonTypeMention:
            [self keyboardToolBarWithMentionType];
            break;
            
        case FKeyboardToolBarButtonTypeEmotion:
            [self keyboardToolBarWithEmotionType];
            break;
            
        default:
            break;
    }
}

// 摄像机 摄像
- (void)keyboardToolBarWithCameraType
{
    // 相机不能用就返回
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

// 打开相册
- (void)keyboardToolBarWithPictureType
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])return;
   
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)keyboardToolBarWithTrendType
{
    NSLog(@"FKeyboardToolBarButtonTypeTrend");

}

- (void)keyboardToolBarWithMentionType
{
    NSLog(@"FKeyboardToolBarButtonTypeMention");

}

// 打开表情键盘
- (void)keyboardToolBarWithEmotionType
{
    
    if (self.textView.inputView == nil) { // 使用的是系统键盘
        self.textView.inputView = self.emotionKeyboard; // 切换到表情键盘
        self.keyboardToolBar.emotionKeyboard = NO; // 应该显示系统键盘图标
    } else { // 使用的是 自定义键盘
        self.textView.inputView = nil;
        self.keyboardToolBar.emotionKeyboard = YES;
    }
    self.switchKeyboard = YES;
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.switchKeyboard = NO;
       [self.textView becomeFirstResponder];
    });
}


// 代理类方法，用于选择图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%@", info);
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

















