//
//  KYFollowCategory.h
//  百思不得姐
//
//  Created by 郑开元 on 15/9/22.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KYFollowCategory : NSObject
/** id */
@property (nonatomic, copy) NSString * category_id;
/** 名字 */
@property (nonatomic, copy) NSString *name;

/** 这组的用户总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前的页码 */
@property (nonatomic, assign) NSInteger page;
/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray *users;
@end
