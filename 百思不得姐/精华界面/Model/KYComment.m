//
//  KYComment.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/18.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYComment.h"

@implementation KYComment

- (NSString *)description
{
    return [NSString stringWithFormat:@"KYComment description:%@\n content: %@\nuser: %@\n",[super description], self.content, self.user];
}
@end
