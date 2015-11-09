//
//  KYFollowCategory.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/22.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYFollowCategory.h"
#import <MJExtension.h>
@implementation KYFollowCategory
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"category_id":@"id"};
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"KYFollowCategory description:%@\n name: %@\ntotal: %zd\npage: %zd\nusers: %@\n",[super description], self.name, self.total, self.page, self.users];
}
@end
