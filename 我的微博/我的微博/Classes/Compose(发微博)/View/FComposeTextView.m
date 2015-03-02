//
//  FComposeTextView.m
//  Weibo
//
//  Created by fenggeren on 15/1/25.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FComposeTextView.h"

@interface FComposeTextView ()

// 占位符
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation FComposeTextView

- (id)init
{
    if (self = [super init]) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        self.placeholderLabel = label;
        self.font = [UIFont systemFontOfSize:14];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginingEditing) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/** 重写此方法，因为富文本输入图片时，因为是拼接的，不会调用UITextViewTextDidChangeNotification的监听方法，so。 */
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self beginingEditing];
}

// 监听self 根据self是否有内容，设置占位符的隐藏与否
- (void)beginingEditing
{
    self.placeholderLabel.hidden = self.hasText;
    // 控制器中的 发送按钮 和 占位标签的隐藏 有关 --- 标签隐藏--可以发微博
    if ([self.delegateCompose respondsToSelector:@selector(composeTextViewDidEnable:enableSend:)]) {
        [self.delegateCompose composeTextViewDidEnable:self enableSend:self.placeholderLabel.hidden];
    }
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setupPlaceholdLabelSize];
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    
    self.placeholderLabel.text = self.placeholder;
    
    [self setupPlaceholdLabelSize];
}

// 计算占位符标签的尺寸
- (void)setupPlaceholdLabelSize
{
    self.placeholderLabel.x = 0;
    self.placeholderLabel.y = 8;

    self.placeholderLabel.size = [self.placeholder boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size;
}

@end









