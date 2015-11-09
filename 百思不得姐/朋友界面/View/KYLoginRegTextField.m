//
//  KYLoginRegTextField.m
//  百思不得姐
//
//  Created by 郑开元 on 15/10/19.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYLoginRegTextField.h"

#define KYDefaultColor [UIColor grayColor]
#define KYFocusColor [UIColor whiteColor]
@implementation KYLoginRegTextField

- (void)awakeFromNib
{
    self.tintColor = KYFocusColor;
    
    self.textColor = KYFocusColor;
    
    self.placeHolderColor = KYDefaultColor;
}
- (BOOL)becomeFirstResponder
{
    self.placeHolderColor = KYFocusColor;
    return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
    self.placeHolderColor = KYDefaultColor;
    return [super resignFirstResponder];
}
@end
