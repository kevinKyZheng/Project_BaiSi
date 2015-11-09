//
//  KYTopic.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/14.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTopic.h"
#import "NSDate+KYComparaion.h"

@implementation KYTopic
- (NSString *)created_at
{
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * createdAtDate = [fmt dateFromString:_created_at];
    NSDateComponents * components = [createdAtDate intervalToNow];
    if ([createdAtDate isThisYear]) {
        if ([createdAtDate isToday]) {//是今天
            if (components.hour >= 1) {
                return [NSString stringWithFormat:@"%zd小时前",components.hour];
            }else if (components.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",components.minute];
            }else{
                return @"刚刚";
            }
        }else if ([createdAtDate isYesterday]){//是昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createdAtDate];
        }else{//是今年的其他时间
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createdAtDate];
        }
    }else{//非今年
        return  _created_at;
    }
}
- (CGFloat)rowHeight
{
    if (_rowHeight == 0) {//只设置一次
        //设置顶部的高度
        _rowHeight = KYTopicTopHeight;
        //设置段子的高度
        CGFloat textW = KYScreenW - KYCommonInset * 2;
        CGFloat textH = [self.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:17]} context:nil].size.height;
        _rowHeight += textH + KYCommonInset;
        //计算内容的高度
        if (self.type != KYTopicTypeWord) {
            CGFloat contentW = textW;
            CGFloat contentH = self.height * contentW / self.width;
            if (contentH >= KYScreenH) {//大图片,高度超过屏幕
                contentH = 200;
                self.isBigPicture = YES;
            }
            self.contentFrame = CGRectMake(KYCommonInset, _rowHeight, contentW, contentH);
            _rowHeight += contentH;
        }
        //计算最热评论的高度
        if (self.top_cmt) {
            NSString * userName = self.top_cmt.user.username;
            NSString * content = self.top_cmt.content;
            NSString * contentText = [NSString stringWithFormat:@"%@ : %@",userName,content];
            CGFloat contentTextHeight = [contentText boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.height;
            _rowHeight += KYCommonInset + contentTextHeight + KYTopicCommentTop;
        }
        _rowHeight += KYTopicBottomHeight + KYCommonInset *2;
    }
    return _rowHeight;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"KYTopic description:%@\n name: %@\nprofile_image: %@\ntext: %@\ncreated_at: %@\nding: %zd\ncai: %zd\nrepost: %zd\ncomment: %zd\nis_gif: %i\ntype: %u\nwidth: %f\nheight: %f\ntop_cmt: %@\nvideotime: %zd\nvoicetime: %zd\nplaycount: %zd\nrowHeight: %f\ncontentFrame: %@\nisBigPicture: %i\n",[super description], self.name, self.profile_image, self.text, self.created_at, self.ding, self.cai, self.repost, self.comment, self.is_gif, self.type, self.width, self.height, self.top_cmt, self.videotime, self.voicetime, self.playcount, self.rowHeight, NSStringFromCGRect(self.contentFrame), self.isBigPicture];
}
@end
