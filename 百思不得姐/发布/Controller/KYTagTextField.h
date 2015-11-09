//
//  KYTagTextField.h
//  百思不得姐
//
//  Created by 郑开元 on 15/11/3.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYTagTextField : UITextField
@property (nonatomic,copy)void(^deleteBackOpertion)();
@end
