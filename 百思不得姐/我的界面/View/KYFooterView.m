//
//  KYFooterView.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/7.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYFooterView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "KYSquare.h"
#import "KYFooterBtn.h"
#import "KYWebViewController.h"

@implementation KYFooterView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        NSMutableDictionary * para=[NSMutableDictionary dictionary];
        
        para[@"a"]=@"square";
        para[@"c"]=@"topic";
        KYWeakSelf
        [[AFHTTPSessionManager manager]GET:KYRequestUrl parameters:para success:^(NSURLSessionDataTask *task, id responseObject) {
            [weakSelf creatFooter:[KYSquare objectArrayWithKeyValuesArray:responseObject[@"square_list"]]];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
         }
    return self;
}
-(void)creatFooter:(NSArray *)array
{
    NSUInteger count=array.count;
    NSInteger collumCount=4;
    //按钮的宽度和高度
    CGFloat btnW=self.width/collumCount;
    CGFloat btnH=btnW;
    
    for (int i=0;i<count;i++) {
        KYFooterBtn * btn=[[KYFooterBtn alloc]init];
        [btn addTarget:self action:@selector(footBtnPress:) forControlEvents:(UIControlEventTouchUpInside)];
        CGFloat btnX=(i%collumCount)*btnW;
        CGFloat btnY=(i/collumCount)*btnH;
        btn.frame=CGRectMake(btnX, btnY, btnW, btnH);
        btn.square=array[i];
        [self addSubview:btn];
        //设置自身的高度
        self.height=CGRectGetMaxY(btn.frame);
    }
    //设置table的ContentSize
    UITableView * tableView=(UITableView *)self.superview;
    tableView.contentSize=CGSizeMake(0, CGRectGetMaxY(self.frame));
}
/**
 *  按钮的点击事件
 */
-(void)footBtnPress:(KYFooterBtn *)btn
{
    if (![btn.square.url hasPrefix:@"http:"]) return;
    KYWebViewController * webViewVc=[[KYWebViewController alloc]init];
    webViewVc.square=btn.square;
    //取NavController
    UITabBarController * rootVc=(UITabBarController *)self.window.rootViewController;
    UINavigationController * navVc=(UINavigationController *)rootVc.selectedViewController;
    [navVc pushViewController:webViewVc animated:YES];
}
@end
