//
//  FEmotionKeyboard.m
//  Weibo
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionKeyboard.h"
#import "FEmotionToolBar.h"
#import "FEmotionListView.h"
#import "FEmotionModule.h"
#import "FEmotionTool.h"

@interface FEmotionKeyboard () <FEmotionToolBarDelegate>

@property (nonatomic, weak) FEmotionToolBar *toolBar;

@property (nonatomic, weak) FEmotionListView *listView;



@end

@implementation FEmotionKeyboard

- (instancetype)init
{
    if (self = [super init]) {
        
        
        FEmotionListView *listView = [[FEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        FEmotionToolBar *toolBar = [[FEmotionToolBar alloc] init];
        [self addSubview:toolBar];
        toolBar.delegate = self;
        self.toolBar = toolBar;
    }
    
    return self;
}



- (void)emotionToolBarDidClick:(FEmotionToolBar *)toolbar buttonType:(FEmotionToolBarButtonType)buttonType
{
    switch (buttonType) {
        case FEmotionToolBarButtonTypeCommonly:
            self.listView.emotions = [FEmotionTool recentEmotions];
            break;
            
        case FEmotionToolBarButtonTypeDefault:
            self.listView.emotions = [FEmotionTool defaultEmotions];
            break;
            
        case FEmotionToolBarButtonTypeEmoji:
            self.listView.emotions = [FEmotionTool emojiEmotions];
            break;

        case FEmotionToolBarButtonTypeLxh:
            self.listView.emotions = [FEmotionTool lxhEmotions];
            break;

        default:
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.toolBar.height = 44;
    self.toolBar.y = self.height - self.toolBar.height;
    self.toolBar.width = self.width;
    
    self.listView.height = self.height - self.toolBar.height;
    self.listView.width = self.width;
}

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"emoticon_keyboard_background"] drawInRect:rect];
}

@end

















