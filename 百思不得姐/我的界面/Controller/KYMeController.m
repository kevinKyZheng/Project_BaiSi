//
//  KYMeController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/1.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYMeController.h"
#import "KYMeCell.h"
#import "KYFooterView.h"
#import "KYSettingController.h"
#import <AFNetworking.h>
static NSString * const meCellId=@"ME_CELL";

@implementation KYMeController
-(void)viewDidLoad
{
    //配置Nav
    [self setupNav];
    //配置TableView
    [self setupTableView];
}
//配置TableView
-(void)setupTableView
{
    //设置背景色
    self.tableView.backgroundColor=KYBGColor;
    //设置向上缩进
    self.tableView.contentInset=UIEdgeInsetsMake(KYCommonInset-35, 0, 0, 0);
    //设置section间距
    self.tableView.sectionFooterHeight=KYCommonInset;
    self.tableView.sectionHeaderHeight=0;
    //注册cell
    [self.tableView registerClass:[KYMeCell class] forCellReuseIdentifier:meCellId];
    //添加footer
    self.tableView.tableFooterView=[[KYFooterView alloc]init];
    /**在设置footerView的那一刻,计算contentSize,所以在之后设置footer的高度,没用.会导致拉不上来.
        解决:1.设置完高度后,在重新设置footerView
            2.重新设置contentSize
     */
}
//配置Nav
-(void)setupNav
{
   self.navigationItem.title=@"我的";
    UIBarButtonItem * moonBtn=[UIBarButtonItem itemWithImage:@"mine-moon-icon" andSelectedImage:@"mine-moon-icon-click" andTarget:self andAction:@selector(moonClick)];
    UIBarButtonItem * setting=[UIBarButtonItem itemWithImage:@"mine-setting-icon" andSelectedImage:@"mine-setting-icon-click" andTarget:self andAction:@selector(settingClick)];
    self.navigationItem.rightBarButtonItems=@[moonBtn,setting];
}
-(void)moonClick
{
    
}
-(void)settingClick
{
    KYSettingController * settingVc=[[KYSettingController alloc]initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:settingVc animated:YES];
}
#pragma mark dataSourece
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KYMeCell * cell=[tableView dequeueReusableCellWithIdentifier:meCellId];
    if (indexPath.section==0) {
        cell.imageView.image=[UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text=@"登陆/注册";
    }else{
        cell.textLabel.text=@"离线下载";
    }
    return cell;
}
@end
