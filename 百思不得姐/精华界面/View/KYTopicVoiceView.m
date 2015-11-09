//
//  KYTopicVoiceView.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/18.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTopicVoiceView.h"
#import "KYTopic.h"
#import <UIImageView+WebCache.h>

@interface KYTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation KYTopicVoiceView

- (void)awakeFromNib
{
 self.autoresizingMask = UIViewAutoresizingNone;
}
- (void)setTopic:(KYTopic *)topic
{
    _topic =topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1]];
    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //播放时长
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.durationLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

@end
