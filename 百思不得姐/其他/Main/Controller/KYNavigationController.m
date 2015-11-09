//
//  KYNavigationController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/8.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYNavigationController.h"

@interface KYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation KYNavigationController
+ (void)initialize
{
    //设置NavBar
    UINavigationBar * navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]  forBarMetrics:UIBarMetricsDefault];
        //设置标题文字属性
    NSMutableDictionary * barAttr=[NSMutableDictionary dictionary];
    barAttr[NSFontAttributeName]=[UIFont boldSystemFontOfSize:20];
    [navBar setTitleTextAttributes:barAttr];
    //设置BarItem
    UIBarButtonItem * barButtonItem = [UIBarButtonItem appearance];
        //设置normal的文字状态
    NSMutableDictionary * normalAttr=[NSMutableDictionary dictionary];
    normalAttr[NSForegroundColorAttributeName]=[UIColor blackColor];
    normalAttr[NSFontAttributeName]=[UIFont systemFontOfSize:17];
    [barButtonItem setTitleTextAttributes:normalAttr forState:(UIControlStateNormal)];
        //设置disable的文字状态
    NSMutableDictionary * disableAttr=[NSMutableDictionary dictionary];
    disableAttr[NSForegroundColorAttributeName]=[UIColor grayColor];
    disableAttr[NSFontAttributeName]=[UIFont systemFontOfSize:17];
    [barButtonItem setTitleTextAttributes:disableAttr forState:(UIControlStateDisabled)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate=self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.childViewControllers.count>=1) {
        UIButton * btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:(UIControlStateHighlighted)];
        [btn setTitle:@"返回" forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        [btn addTarget:self action:@selector(backBtnPress) forControlEvents:(UIControlEventTouchUpInside)];
        [btn sizeToFit];
        btn.contentEdgeInsets=UIEdgeInsetsMake(0, -20, 0, 0);
        UIBarButtonItem * barItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
        viewController.navigationItem.leftBarButtonItem=barItem;
        //隐藏底部工具条
        viewController.hidesBottomBarWhenPushed=YES;
    }
    
    [super pushViewController:viewController animated:animated];
}
-(void)backBtnPress
{
    [self popViewControllerAnimated:YES];
}
#pragma mark 手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count>1;
}
@end
