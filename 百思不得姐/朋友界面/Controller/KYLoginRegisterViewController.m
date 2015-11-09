//
//  KYLoginRegisterViewController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/23.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYLoginRegisterViewController.h"

@interface KYLoginRegisterViewController ()

@end

@implementation KYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated
{

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
-(void)viewWillDisappear:(BOOL)animated
{
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
 

@end
