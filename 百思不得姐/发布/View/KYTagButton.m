//
//  KYTagButton.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/15.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTagButton.h"

@implementation KYTagButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KYTagBgColor;
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:(UIControlStateNormal)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    
    self.height = KYTagHeight;
    self.width += 3 * KYSmallMargin;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x = KYSmallMargin;
    
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + KYSmallMargin;
}
@end
