//
//  KYSettingController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/8.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYSettingController.h"
#import "KYClearCacheCell.h"

@interface KYSettingController ()

@end

static NSString * const clearCacheID=@"clearCacheCell";
@implementation KYSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor=KYBGColor;
    //注册cell
    [self.tableView registerClass:[KYClearCacheCell class] forCellReuseIdentifier:clearCacheID];
}
#pragma mark DateSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KYClearCacheCell * cell=[tableView dequeueReusableCellWithIdentifier:clearCacheID];
    //更新状态
    [cell updateStatus];
    return cell;
}
#pragma mark delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    KYClearCacheCell * cell=(KYClearCacheCell *)[tableView cellForRowAtIndexPath:indexPath];
    //清空缓存
    [cell clearCache];
}
@end
