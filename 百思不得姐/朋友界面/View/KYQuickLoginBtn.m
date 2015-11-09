//
//  KYQuickLoginBtn.m
//  百思不得姐
//
//  Created by 郑开元 on 15/10/9.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYQuickLoginBtn.h"

@implementation KYQuickLoginBtn

- (void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //image
    self.imageView.y = 0;
    self.imageView.centerX = self.width * 0.5;
    //title
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + KYSmallMargin;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
