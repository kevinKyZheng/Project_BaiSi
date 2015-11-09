//
//  KYUser.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/18.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYUser.h"

@implementation KYUser

- (NSString *)description
{
    return [NSString stringWithFormat:@"KYUser description:%@\n username: %@\nsex: %@\nprofile_image: %@\n",[super description], self.username, self.sex, self.profile_image];
}
@end
