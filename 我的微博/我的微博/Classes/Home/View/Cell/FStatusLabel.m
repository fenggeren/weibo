//
//  FStatusLabel.m
//  我的微博
//
//  Created by fenggeren on 15/2/10.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FStatusLabel.h"
#import "FStatusLink.h"
#import "FStatusLink.h"

#define FLinkTag   1000 // 设置点击到特殊字段是的背景view的tag

@interface FStatusLabel ()

/** 用于显示文字 */
@property (nonatomic, weak) UITextView *textView;

/** 存放微博正文的所有特殊字段FStatusLink */
@property (nonatomic, strong) NSArray *links;

/** 触摸点击中的 特殊字段 */
@property (nonatomic, weak) FStatusLink *link;
@end

@implementation FStatusLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = [UIColor clearColor];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.userInteractionEnabled = NO;
        // 默认值是(0,8,0,8)，所以左右会有空隙，文字填充控件不够；
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        [self addSubview:textView];
        self.textView = textView;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = [attributedText copy];
    self.textView.attributedText = attributedText;
    self.links = nil; // 控件复用，每个控件都有自己的特殊字段
}

- (NSArray *)links
{
    if (!_links) {
        NSMutableArray *array = [NSMutableArray array];
        // 遍历整个微博 富文本正文
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            NSString *attriLink = attrs[FAttributedStringOfStatus]; // 获取微博特殊字段
            if (attriLink) { // 是特殊字段
                FStatusLink *link = [[FStatusLink alloc] init];
                link.range = range;
                link.text = attriLink;
                
                self.textView.selectedRange = range;
                // 获取一个特殊字段的 所有rect// 可能占两行
                link.rects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
                
                [array addObject:link];
            }
        }];
        
        _links = array;
    }
    
    return _links;
}

/** 根据触摸点 返回触摸的特殊字段 模型 */
- (FStatusLink *)linkWithPoint:(CGPoint)touchedPos
{
    // 遍历微博的所有 特殊字段
    for (FStatusLink *link in self.links) {
        for (UITextSelectionRect *range in link.rects) {
            if (CGRectContainsPoint(range.rect, touchedPos)) { // 触摸点在 特殊字段rect内
                return link;
            }
        }
    }
    
    return nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    UITouch *touch = [touches anyObject];
//    CGPoint pos = [touch locationInView:touch.view];

//    FStatusLink *link = [self linkWithPoint:pos];
    if (self.link) { // 点击到了 特殊字段 self.link 在- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event首次被计算出，发生触摸事件时，也会首先调用此方法；
        for (UITextSelectionRect *rect in self.link.rects) { // 遍历特殊字段的所有rect，设置背景色
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor redColor];
            view.alpha = 0.5;
            view.frame = rect.rect;
            view.tag = FLinkTag;
            [self addSubview:view];
        }
//        self.link = link;
    }
}

// 如果选中了一个特殊字段， 则发送通知给控制器；
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.link) {
       [[NSNotificationCenter defaultCenter] postNotificationName:FAttributeTextDidSelectedNotification object:self userInfo:@{FAttributeTextDidSelectedKey : self.link.text}];
        
        [self touchesCancelled:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.link) {
        self.link = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeAllLinkBackgroundView];
        });        
    }

}

/** 移除点击特殊字段时 添加的背景view */
- (void)removeAllLinkBackgroundView
{
    for (UIView *view in self.subviews) {
        if (view.tag == FLinkTag) {
            [view removeFromSuperview];
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ((self.link = [self linkWithPoint:point])) {
        return self;
    } else {
        return nil;
    }
}

@end




























