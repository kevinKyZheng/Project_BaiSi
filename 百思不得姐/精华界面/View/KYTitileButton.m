//
//  KYTitileButton.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/13.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTitileButton.h"

@implementation KYTitileButton

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        [self setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
    }
    return self;
}
//取消highlight下的一切状态
- (void)setHighlighted:(BOOL)highlighted{
}

@end
