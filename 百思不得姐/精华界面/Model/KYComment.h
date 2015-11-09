//
//  KYComment.h
//  百思不得姐
//
//  Created by 郑开元 on 15/9/18.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KYUser.h"
@interface KYComment : NSObject
/** 文字内容 */
@property (nonatomic, copy) NSString *content;

/** 用户 */
@property (nonatomic, strong) KYUser *user;
@end
