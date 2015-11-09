//
//  KYFriendController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/1.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYFriendController.h"
#import "KYRecommandFollowViewController.h"
#import "KYLoginRegisterViewController.h"

@implementation KYFriendController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    self.view.backgroundColor = KYBGColor;
    self.view.frame = CGRectMake(100, 100, 200, 200);
    
}
- (void)setupNav
{
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" andSelectedImage:@"friendsRecommentIcon-click" andTarget:self andAction:@selector(friendRecBtnClick)];
}
//Nav左上角推荐按钮的点击事件
- (void)friendRecBtnClick
{
    KYRecommandFollowViewController * RecFollowVc = [[KYRecommandFollowViewController alloc]init];
    [self.navigationController pushViewController:RecFollowVc animated:YES];
}
//登陆按钮点击事件
- (IBAction)loginBtnClick:(id)sender {
    KYLoginRegisterViewController * logRegVc = [[KYLoginRegisterViewController alloc]init];
    [self presentViewController:logRegVc animated:YES completion:nil];
}
- (IBAction)registerBtnClick:(id)sender {
    
}
@end
