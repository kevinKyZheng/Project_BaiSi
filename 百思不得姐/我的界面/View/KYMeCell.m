//
//  KYMeCell.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/7.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYMeCell.h"

@implementation KYMeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.textColor=[UIColor grayColor];
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image==nil) return;
    
    self.imageView.y=KYCommonInset*0.8;
    self.imageView.height=self.contentView.height-2*self.imageView.y;
    self.imageView.width=self.imageView.height;
    
    self.textLabel.x=CGRectGetMaxX(self.imageView.frame)+KYCommonInset;
}

@end
