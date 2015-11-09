//
//  KYFollowUser.h
//  百思不得姐
//
//  Created by 郑开元 on 15/9/22.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KYFollowUser : NSObject
/** 粉丝数 */
@property (nonatomic, assign) NSInteger fans_count;
/** 头像 */
@property (nonatomic, copy) NSString *header;
/** 昵称 */
@property (nonatomic, copy) NSString *screen_name;
@end
