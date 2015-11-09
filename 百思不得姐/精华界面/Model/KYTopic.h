//
//  KYTopic.h
//  百思不得姐
//
//  Created by 郑开元 on 15/9/14.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KYComment.h"

typedef enum {
    /** 图片 */
    KYTopicTypePicture = 10,
    
    /** 段子(文字) */
    KYTopicTypeWord = 29,
    
    /** 声音 */
    KYTopicTypeVoice = 31,
    
    /** 视频 */
    KYTopicTypeVideo = 41,
    /** 全部 */
    KYTopicTypeAll = 1,
}KYTopicType;

@interface KYTopic : NSObject
// 用户 -- 发帖者
/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/** 是否为动态图 */
@property (nonatomic, assign) BOOL is_gif;
/** 类型 */
@property (nonatomic, assign) KYTopicType type;
/** 图片的宽度 */
@property (nonatomic, assign) CGFloat width;
/** 图片的高度 */
@property (nonatomic, assign) CGFloat height;

/** 图片 */
@property (nonatomic, copy) NSString * image0;
/** 图片 */
@property (nonatomic, copy) NSString * image1;
/** 图片 */
@property (nonatomic, copy) NSString * image2;

/** 最热评论*/
@property (nonatomic, strong) KYComment *top_cmt;

/** 视频的时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 播放数量 */
@property (nonatomic, assign) NSInteger playcount;

/** 其他属性   */
/** 行高   */
@property (nonatomic,assign) CGFloat rowHeight;
/** 图片Frame   */
@property (nonatomic,assign) CGRect contentFrame;
/** 是否是大图 */
@property (nonatomic,assign) BOOL isBigPicture;


@end
