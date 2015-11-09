//
//  KYPlaceHolderTextView.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/10.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYPlaceHolderTextView.h"

@implementation KYPlaceHolderTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame] ) {
        //设置默认文字颜色和字体
        self.placeHolderColor=[UIColor grayColor];
        self.font=[UIFont systemFontOfSize:15];
        //设置监听
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidchange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)textDidchange
{
    [self setNeedsDisplay];
}
-(void)drawRect:(CGRect)rect
{
    if (self.hasText) return;
    NSMutableDictionary * textAttr=[NSMutableDictionary dictionary];
    textAttr[NSFontAttributeName]=self.font;
    textAttr[NSForegroundColorAttributeName]=self.placeHolderColor;
    
    rect.origin.x=5;
    rect.origin.y=8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeHolder drawInRect:rect withAttributes:textAttr];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self setNeedsDisplay];
}
#pragma mark 重写set方法
-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder=[placeHolder copy];
    [self setNeedsDisplay];
}
-(void)setPlaceHolderColor:(UIColor *)placeHolderColor
{
    _placeHolderColor=placeHolderColor;
    [self setNeedsDisplay];
}
-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}

@end
