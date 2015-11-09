//
//  KYTopicPictureView.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/16.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import <DALabeledCircularProgressView.h>
#import "KYTopic.h"
#import "KYSeeBigPictureController.h"

@interface KYTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet DALabeledCircularProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;

@end

@implementation KYTopicPictureView
- (void)awakeFromNib
{
    //出现打破自动布局限制的问题
    // 清空自动伸缩属性
    self.autoresizingMask = UIViewAutoresizingNone;
    //设置progress的圆角
    self.progressView.roundedCorners = 5;
    //
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick)]];
}
//点击图片的响应
- (void)imageClick
{
    KYSeeBigPictureController * seeBigPicVc =[[KYSeeBigPictureController alloc]init];
    seeBigPicVc.topic = self.topic;
    [self.window.rootViewController presentViewController:seeBigPicVc animated:YES completion:nil];
}
- (void)setTopic:(KYTopic *)topic
{
    _topic = topic;
    
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1]];
    KYWeakSelf
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.image1] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        weakSelf.progressView.hidden = NO;
        weakSelf.progressView.progress =1.0 * receivedSize / expectedSize;
        weakSelf.progressView.progressLabel.text = [NSString stringWithFormat:@"%.0f%%",weakSelf.progressView.progress * 100];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.progressView.hidden = YES;
    }];
    //gif
    self.gifView.hidden = !topic.is_gif;
    //看大图按钮
    self.seeBigPictureView.hidden = !topic.isBigPicture;
    if (topic.isBigPicture) {//调整图片的显示模式
        self.imageView.contentMode = UIViewContentModeCenter;
        self.imageView.clipsToBounds = YES;
    }else{
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}
@end
