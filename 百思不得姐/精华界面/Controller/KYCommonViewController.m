//
//  KYCommonViewController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/13.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYCommonViewController.h"
#import "KYTopicCell.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "KYTopic.h"
#import "KYCommentViewController.h"

@interface KYCommonViewController ()
//模型数据
@property(nonatomic,strong)NSMutableArray * topics;
//用于加载下一页数据
@property (nonatomic,copy)NSString * maxtime;
//
@property(nonatomic,strong)AFHTTPSessionManager * manager;

@end
//cell标示
static NSString * const  cellID = @"topic";

@implementation KYCommonViewController

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self setupRefresh];
}
/**初始化TableView*/
- (void)setupTableView
{
    self.view.backgroundColor=KYBGColor;
    //设置缩进
    self.tableView.contentInset = UIEdgeInsetsMake(KYTitleViewHeight + KYNavHeight, 0, KYTabBarHeight, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([KYTopicCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    //取消选中效果
    
}
/**初始化刷新控件*/
- (void)setupRefresh
{
    //头部
    MJRefreshNormalHeader * header =[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.header = header;
    header.automaticallyChangeAlpha = YES;
    [self.tableView.header beginRefreshing];
    //尾部
    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}
- (void)loadNewData
{
    //取消所有下载任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    KYWeakSelf
    // 请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"data";
    param[@"type"] = @(self.type);
    
    [self.manager GET:KYRequestUrl parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        weakSelf.topics = [KYTopic objectArrayWithKeyValuesArray:responseObject[@"list"]];
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        [weakSelf.tableView reloadData];
        //停止旋转
        [weakSelf.tableView.header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //停止旋转
        [weakSelf.tableView.header endRefreshing];
    }];
}
- (void)loadMoreData
{
    //取消所有下载任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    KYWeakSelf
    // 请求参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"a"] = @"list";
    param[@"c"] = @"data";
    param[@"type"] = @(self.type);
    param[@"maxtime"] = self.maxtime;
    
    [self.manager GET:KYRequestUrl parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [weakSelf.topics addObjectsFromArray: [KYTopic objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        weakSelf.maxtime = responseObject[@"info"][@"maxtime"];
        [weakSelf.tableView reloadData];
        //停止旋转
        [weakSelf.tableView.footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        //停止旋转
        [weakSelf.tableView.footer endRefreshing];
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (KYTopicCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.topic = self.topics[indexPath.row];
    return cell;
}
#pragma mark - Table view delegate
//设置行高
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KYTopic * topic = self.topics[indexPath.row];
    return topic.rowHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    KYCommentViewController * commentVc = [[KYCommentViewController alloc]init];
    commentVc.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVc animated:YES];
}

@end
