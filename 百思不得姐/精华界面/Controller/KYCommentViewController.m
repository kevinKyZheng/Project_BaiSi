//
//  KYCommentViewController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/18.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYCommentViewController.h"
#import "KYTopicCell.h"

@interface KYCommentViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation KYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" andSelectedImage:@"comment_nav_item_share_icon_click" andTarget:nil andAction:nil];
    
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView.backgroundColor = KYBGColor;
    //header
    KYTopicCell * topicCell = [KYTopicCell viewFromXib];
    topicCell.frame = CGRectMake(0, 0, KYScreenW, self.topic.rowHeight);
    topicCell.topic = self.topic;
    
    
    UIView * headView =[[UIView alloc]init];
    headView.backgroundColor = [UIColor blueColor];
    headView.frame = CGRectMake(0, 0, KYScreenW, topicCell.height+2*KYCommonInset);
    [headView addSubview:topicCell];
    self.tableView.tableHeaderView = headView;
    //cell
    [self.tableView registerNib:[UINib nibWithNibName:@"KYCommentCell" bundle:nil] forCellReuseIdentifier:@"comment"];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"comment"];
    return cell;
}
@end
