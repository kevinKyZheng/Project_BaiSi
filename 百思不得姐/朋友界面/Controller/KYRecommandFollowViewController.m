//
//  KYRecommandFollowViewController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/22.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYRecommandFollowViewController.h"
#import "KYCategoryCell.h"
#import "KYUserCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "KYFollowCategory.h"
#import <MJExtension.h>
#import "KYFollowUser.h"

#define KYSelectedCategory self.followCategory[self.categoryTableView.indexPathForSelectedRow.row];
@interface KYRecommandFollowViewController ()<UITableViewDelegate,UITableViewDataSource>

/**左边👈的类别表格*/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/**右边👈的用户表格*/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
@property(nonatomic,strong)AFHTTPSessionManager * manager;
/**分类数据数组*/
@property(nonatomic,strong)NSArray * followCategory;
/**右边👈的数据*/
@property(nonatomic,strong)NSArray * followUsers;


@end

static NSString * const CategoryCellId = @"category";
static NSString * const UserCellId = @"user";

@implementation KYRecommandFollowViewController
#pragma mark 懒加载
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self settupRefresh];
    
    [self loadCategory];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [self.manager invalidateSessionCancelingTasks:YES];
}
- (void)setupTableView
{
    self.navigationItem.title = @"推荐关注";
    //调整边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets insets = UIEdgeInsetsMake(KYNavHeight, 0, 0, 0);
    self.categoryTableView.contentInset = insets;
    self.userTableView.contentInset = insets;
    
    self.categoryTableView.scrollIndicatorInsets = insets;
    self.categoryTableView.scrollIndicatorInsets = insets;
    //取消分割线效果
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([KYCategoryCell class]) bundle:nil] forCellReuseIdentifier:CategoryCellId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([KYUserCell class]) bundle:nil] forCellReuseIdentifier:UserCellId];
    //cell高度
    self.userTableView.rowHeight = 70;
    //设置背景色
    self.userTableView.backgroundColor =KYBGColor;
    self.categoryTableView.backgroundColor = KYBGColor;
}

- (void)loadCategory
{
    //
    [SVProgressHUD show];
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        KYWeakSelf
        [self.manager GET:KYRequestUrl parameters:params success:^(NSURLSessionDataTask * dataTask, id responseObject) {
            [SVProgressHUD dismiss];
            //字典转模型
            weakSelf.followCategory =[KYFollowCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //刷新表格
            [weakSelf.categoryTableView reloadData];
            //选中左边第0行
            [weakSelf.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];
            [weakSelf.userTableView.header beginRefreshing];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            [SVProgressHUD dismiss];
        }];
//    });
 
}

- (void)settupRefresh
{
    self.userTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUser)];
     MJRefreshAutoNormalFooter * footer= [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUser)];
    self.userTableView.footer = footer;
}
//下拉刷新
- (void)loadNewUser
{
    //取消之前的任务
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    KYFollowCategory * selectedCategory = self.followCategory[self.categoryTableView.indexPathForSelectedRow.row];
    params[@"category_id"] = selectedCategory.category_id;
        KYWeakSelf
        [self.manager GET:KYRequestUrl parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
            
            selectedCategory.users= [KYFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //储存数据的总数
            selectedCategory.total = [responseObject[@"total"] integerValue];
            //刷新数据
            [weakSelf.userTableView reloadData];
            //结束刷新
            [weakSelf.userTableView.header endRefreshing];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            //结束刷新
            [self.userTableView.header endRefreshing];
            
        }];
}
//上拉加载更多数据
- (void)loadMoreUser
{
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    KYFollowCategory * selectedCategory = self.followCategory[self.categoryTableView.indexPathForSelectedRow.row];
    params[@"category_id"] = selectedCategory.category_id;
    NSInteger page = selectedCategory.page +1;
    params[@"page"] = @(page);
    //发起网络请求
    KYWeakSelf
    [self.manager GET:KYRequestUrl parameters:params success:^(NSURLSessionDataTask * task, id responseObject) {
        selectedCategory.page = page;
        //添加数据
        NSArray * array = [KYFollowUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //储存数据的总数
        selectedCategory.total = [responseObject[@"total"] integerValue];
        //储存新的数据
        [selectedCategory.users addObjectsFromArray:array];
        [weakSelf.userTableView reloadData];
        //判断是否加载完毕
        if (selectedCategory.users.count >= selectedCategory.total) {//加载完毕
            self.userTableView.footer.hidden = YES;
        }else{
                [weakSelf.userTableView.footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        [weakSelf.userTableView.footer endRefreshing];
    }];
}
#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.followCategory.count;
    }else{
         KYFollowCategory * selectedCategory = self.followCategory[self.categoryTableView.indexPathForSelectedRow.row];
        return selectedCategory.users.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        KYCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:CategoryCellId];
        cell.category = self.followCategory[indexPath.row];
        return cell;
    }else{
        KYUserCell * cell = [tableView dequeueReusableCellWithIdentifier:UserCellId];
        KYFollowCategory * selectedCategory=self.followCategory[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = selectedCategory.users[indexPath.row];
        return cell;
    }
}
#pragma mark delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {//点击的左边的表格
        KYFollowCategory * selectedCategory = self.followCategory[indexPath.row];
        //有数据就加载数据
        [self.userTableView reloadData];
        //判断是否需要显示footer
        if (selectedCategory.users.count >= selectedCategory.total) {
            self.userTableView.footer.hidden = YES;
        }
        //判断是否需要加载数据
        if (selectedCategory.users.count == 0) {//说明没有数据
            [self.userTableView.header beginRefreshing];
        }
    }else{//点击的右边的表格
        
    }
}
@end
