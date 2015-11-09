//
//  KYCategoryCell.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/22.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYCategoryCell.h"

@interface KYCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation KYCategoryCell

- (void)awakeFromNib {
    //懒加载,textlabel是后加载的,所以会盖住部分分割线.
    self.textLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.textLabel.textColor = selected? [UIColor redColor] : [UIColor grayColor];
    self.selectedIndicator.hidden = !selected;

}
-(void)setCategory:(KYFollowCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}
@end
