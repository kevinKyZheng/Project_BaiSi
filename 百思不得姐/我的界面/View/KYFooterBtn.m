//
//  KYFooterBtn.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/7.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYFooterBtn.h"
#import <UIButton+WebCache.h>
#import "KYSquare.h"
@implementation KYFooterBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.titleLabel.textAlignment=NSTextAlignmentCenter;
        self.titleLabel.font=[UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:(UIControlStateNormal)];
    }
    return self;
}
//调整内部子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.width=self.width*0.5;
    self.imageView.height=self.imageView.width;
    self.imageView.centerX=self.width*0.5;
    self.imageView.y=self.imageView.height*0.2;
    
    self.titleLabel.width=self.width;
    self.titleLabel.height=self.height-self.imageView.height;
    self.titleLabel.x=0;
    self.titleLabel.y=CGRectGetMaxY(self.imageView.frame);
}
//填充数据
-(void)setSquare:(KYSquare *)square
{
    _square=square;
    [self setTitle:square.name forState:UIControlStateNormal];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
}
@end
