//
//  KYPublishButton.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/9.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYPublishButton.h"
@implementation KYPublishButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    }
    return self;
}
//布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    //image
    self.imageView.centerX=self.width*0.5;
    self.imageView.y=0;
//    self.imageView.width=self.width*0.5;
//    self.imageView.height=self.height*0.3;
    //title
    self.titleLabel.y=CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.x=0;
    self.titleLabel.width=self.width;
    self.titleLabel.height=self.height-self.titleLabel.y;
}
@end
