//
//  KYTopicCell.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/14.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTopicCell.h"
#import "KYTopicPictureView.h"
#import "KYTopicVedioView.h"
#import "KYTopicVoiceView.h"

@interface KYTopicCell ()
//顶部栏的姓名,头像,时间,段子
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
//工具栏的四个按钮
@property (weak, nonatomic) IBOutlet UIButton *ding;
@property (weak, nonatomic) IBOutlet UIButton *cai;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *share;
//中间的内容View
@property(nonatomic,weak)KYTopicPictureView * pictureView;
@property(nonatomic,weak)KYTopicVedioView * vedioView;
@property(nonatomic,weak)KYTopicVoiceView * voiceView;
//最热评论
@property (weak, nonatomic) IBOutlet UIView *topCmt;
@property (weak, nonatomic) IBOutlet UILabel *topContent;
@end

@implementation KYTopicCell

-(KYTopicPictureView *)pictureView
{
    if (!_pictureView) {
        KYTopicPictureView * pictureView = [KYTopicPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
-(KYTopicVedioView *)vedioView
{
    if (!_vedioView) {
        KYTopicVedioView * vedioView = [KYTopicVedioView viewFromXib];
        [self.contentView addSubview:vedioView];
        _vedioView = vedioView;
    }
    return _vedioView;
}
-(KYTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        KYTopicVoiceView * voiceView = [KYTopicVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}
- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}
- (void)setTopic:(KYTopic *)topic
{
    //设置头像
    [self.profileImageView setHeader:topic.profile_image];
    //设置名字
    self.nameLabel.text = topic.name;
    //设置时间
    self.timeLabel.text = topic.created_at;
    
    //设置文字
    self.text_label.text = topic.text;
    topic.ding=0;
    //设置底部工具条的数字
    [self setToolbarNumber:self.ding number:topic.ding placeholder:@"顶"];
    [self setToolbarNumber:self.cai number:topic.cai placeholder:@"踩"];
    [self setToolbarNumber:self.share number:topic.repost placeholder:@"分享"];
    [self setToolbarNumber:self.comment number:topic.comment placeholder:@"评论"];
    // 设置中间显示的内容
    if (topic.type == KYTopicTypePicture) {//图片
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.vedioView.hidden = YES;
        self.pictureView.frame = topic.contentFrame;
        self.pictureView.topic = topic;
    }else if (topic.type == KYTopicTypeVideo){//视频
        self.vedioView.hidden = NO;
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.vedioView.frame = topic.contentFrame;
        self.vedioView.topic = topic;
    }else if (topic.type == KYTopicTypeVoice){//音频
        self.voiceView.hidden = NO;
        self.pictureView.hidden = YES;
        self.vedioView.hidden = YES;
        self.voiceView.frame = topic.contentFrame;
        self.voiceView.topic = topic;
    }else if (topic.type == KYTopicTypeWord){//段子
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.vedioView.hidden = YES;
    }
    //最热评论
    if (topic.top_cmt) {
        self.topCmt.hidden = NO;
        self.topContent.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username,topic.top_cmt.content];
    }else{
        self.topCmt.hidden = YES;
    }
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += KYCommonInset;
    frame.size.height -= KYCommonInset;
    
    [super setFrame:frame];
}
//设置底部工具条数字的方法
- (void)setToolbarNumber:(UIButton *)btn number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [btn setTitle:[NSString stringWithFormat:@"%.1f万",(number / 10000.0)] forState:(UIControlStateNormal)];
    }else if (number > 0){
        [btn setTitle:[NSString stringWithFormat:@"%zd",number] forState:(UIControlStateNormal)];
    }else{
        [btn setTitle:placeholder forState:(UIControlStateNormal)];
    }
}

//更多按钮的点击事件
- (IBAction)moreBtnClick:(id)sender {
//    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报" ,nil];
//    [sheet showInView:self];
    /**iOS8新特性 */
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alertController addAction:[UIAlertAction actionWithTitle:@"举报" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        
    }]];
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];

}

@end
