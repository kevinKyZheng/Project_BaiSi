//
//  UIBarButtonItem+KYExt.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/1.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "UIBarButtonItem+KYExt.h"

@implementation UIBarButtonItem (KYExt)
+(instancetype)itemWithImage:(NSString *)image andSelectedImage:(NSString *)selectedImage andTarget:(id)target andAction:(SEL)action
{
    UIButton * btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:(UIControlStateHighlighted)];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem * barButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    return barButtonItem;
}
@end
