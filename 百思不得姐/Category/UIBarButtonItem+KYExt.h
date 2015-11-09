//
//  UIBarButtonItem+KYExt.h
//  百思不得姐
//
//  Created by 郑开元 on 15/9/1.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (KYExt)
+(instancetype)itemWithImage:(NSString *)image andSelectedImage:(NSString *)selectedImage andTarget:(id)target andAction:(SEL)action;
@end
