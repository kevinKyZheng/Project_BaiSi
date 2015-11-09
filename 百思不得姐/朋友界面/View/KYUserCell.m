//
//  KYUserCell.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/22.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYUserCell.h"

@interface KYUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation KYUserCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)setUser:(KYFollowUser *)user
{
    _user = user;
    [self.headerImageView setHeader:user.header];
    self.screenNameLabel.text = user.screen_name;
    if (user.fans_count >= 10000) {
        self.fansCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }else{
        self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    }
}
@end
