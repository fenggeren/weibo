//
//  FEmotionTextView.m
//  我的微博
//
//  Created by fenggeren on 15/2/9.
//  Copyright (c) 2015年 fenggeren. All rights reserved.
//

#import "FEmotionTextView.h"
#import "FEmotionModule.h"
#import "FEmotionTextAttachment.h"

@implementation FEmotionTextView

- (void)insertEmotion:(FEmotionModule *)emotion
{
   if (emotion.code) { // emoji直接添加
       [self insertText:emotion.emoji];
    } else { // 表情图片
        // 取出已有的富文本
        NSAttributedString *attr = self.attributedText;
        NSMutableAttributedString *textAttr = [[NSMutableAttributedString alloc] initWithAttributedString:attr];
     
        // 记录现在的光标位置，后面用；
        NSRange oldRange = self.selectedRange;
        
        FEmotionTextAttachment *image = [[FEmotionTextAttachment alloc] init];
        image.emotion = emotion;
        // 设置图片大小，和文字等大
        image.bounds = CGRectMake(0, -3, self.font.lineHeight, self.font.lineHeight);
        NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:image];
        
        [textAttr insertAttributedString:imageAttr atIndex:oldRange.location];
        
        // 设置富文本的 字体大小， 如果不设置，会越来越小，因为text的字体大小由font决定，而富文本的大小有属性决定
        [textAttr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textAttr.length)];
        
        // 重新赋值
        self.attributedText = textAttr;
        
        self.selectedRange = NSMakeRange(oldRange.location + 1, oldRange.length);
    }
}

- (NSString *)attributedString
{
    NSMutableString *textStr = [NSMutableString string];
    
    // 用于遍历富文本，其所有的文字被图片分割成一段一段的。。。attrs[@"NSAttachment"]是NSTextAttachment类型，既包含图片
    // 但是仅仅使用系统类NSTextAttachment不能得出emotion模型，所以必须自定义NSTextAttachment的子类包含emotion模型；
    // range 是遍历出的一段/图片 的NSRange
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
        FEmotionTextAttachment *attach = attrs[@"NSAttachment"];
        if (attach) { // 是表情图片
            [textStr appendString:attach.emotion.chs];
        } else {
            NSString *text = [self.attributedText attributedSubstringFromRange:range].string;
            [textStr appendString:text];
        }
    }];
    
    return textStr;
}

@end
