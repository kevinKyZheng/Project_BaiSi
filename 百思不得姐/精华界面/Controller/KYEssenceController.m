//
//  KYEssenceController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/1.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYEssenceController.h"
#import "KYWordViewController.h"
#import "KYPictureViewController.h"
#import "KYVedioViewController.h"
#import "KYAllViewController.h"
#import "KYVoiceViewController.h"
#import "KYTitileButton.h"

@interface KYEssenceController ()<UIScrollViewDelegate>

/**顶部滚动栏里面的Btn*/
@property(nonatomic,strong)NSMutableArray * titleBtns;
/** 当前被选中的Btn */
@property(nonatomic,weak)KYTitileButton * selectedBtn;
/** titleView下面滑动的线 */
@property(nonatomic,weak)UIView * titleBottomView;
/** 用于显示主要内容的ScrollView */
@property(nonatomic,weak)UIScrollView * scrollView;

@end

@implementation KYEssenceController

#pragma mark 懒加载
- (NSMutableArray *)titleBtns
{
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}
#pragma mark 初始化
- (void)viewDidLoad
{
    [self setupNav];
    [self setupChildVc];
// 要先添加ScrollView在添加TitileView否则会覆盖
    [self setupScrollView];
    [self setupTitleView];

}
/**
 * 设置ScrollView
 */
- (void)setupScrollView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * scrollView=[[UIScrollView alloc]init];
    scrollView.backgroundColor=KYBGColor;
    scrollView.contentSize=CGSizeMake(self.childViewControllers.count * self.view.width,0);
    scrollView.frame=self.view.bounds;
    self.scrollView = scrollView;
    scrollView.delegate=self;
    scrollView.pagingEnabled=YES;
    [self.view addSubview:scrollView];
    //默认显示第一个View
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
/**
 * 设置Nav
 */
- (void)setupNav
{
    self.navigationItem.titleView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithImage:@"MainTagSubIcon" andSelectedImage:@"MainTagSubIconClick" andTarget:self andAction:@selector(tagClick)];
}
/**
 * 设置子Vc
 */
- (void)setupChildVc
{
    KYAllViewController * allVc=[[KYAllViewController alloc]init];
    allVc.title=@"全部";
    [self addChildViewController:allVc];
    
    KYVoiceViewController * voiceVc=[[KYVoiceViewController alloc]init];
    voiceVc.title=@"音频";
    [self addChildViewController:voiceVc];

    
    KYWordViewController * wordVc=[[KYWordViewController alloc]init];
    wordVc.title=@"段子";
    [self addChildViewController:wordVc];
    
    KYPictureViewController * pictureVc=[[KYPictureViewController alloc]init];
    pictureVc.title=@"图片";
    [self addChildViewController:pictureVc];
    
    KYVedioViewController * vedioVc=[[KYVedioViewController alloc]init];
    vedioVc.title=@"视频";
    [self addChildViewController:vedioVc];
}
/**
 * 设置滚动的标签栏
 */
- (void)setupTitleView
{
    //设置顶部标签
    UIView * titleView=[[UIView alloc]init];
    titleView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0.5];
    titleView.frame=CGRectMake(0, KYNavHeight, self.view.width, KYTitleViewHeight);
    [self.view addSubview:titleView];
    //设置标签栏内部的按钮
    NSUInteger count = self.childViewControllers.count;
    CGFloat btnW = titleView.width / count;
    CGFloat btnH = titleView.height;
    for (int i=0; i < count; i++) {
        KYTitileButton * btn=[KYTitileButton buttonWithType:(UIButtonTypeCustom)];
        [btn setTitle:[self.childViewControllers[i] title] forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [btn setTitleColor:[UIColor redColor] forState:(UIControlStateSelected)];
        [self.titleBtns addObject:btn];
        btn.frame=CGRectMake(i * btnW, 0, btnW, btnH);
        [titleView addSubview:btn];
    }
//    //设置底部的横线
    UIView * titleBottomView = [[UIView alloc]init];
    titleBottomView.backgroundColor=[self.titleBtns.lastObject titleColorForState:(UIControlStateSelected)];
    titleBottomView.height=2;
    titleBottomView.y=titleView.height-titleBottomView.height;
    [titleView addSubview:titleBottomView];
    self.titleBottomView=titleBottomView;

    //默认点击最前面的按钮
    KYTitileButton * firstBtn=self.titleBtns.firstObject;
    [firstBtn.titleLabel sizeToFit];
#warning 调换位置有影响 //先设置尺寸再设置位置!!
    self.titleBottomView.width=firstBtn.titleLabel.width;
    self.titleBottomView.centerX=firstBtn.centerX;
    [self titleBtnClick:firstBtn];
}
#pragma mark 按钮点击事件
/**
 * 分类按钮点击事件
 */
- (void)tagClick
{
    
}
/**
 * 滚动标签按钮点击事件
 */
- (void)titleBtnClick:(KYTitileButton *)btn
{
    //改变按钮的选中状态
    self.selectedBtn.selected=NO;
    btn.selected=YES;
    self.selectedBtn=btn;
    //底部的线跟着滑动
    [UIView animateWithDuration:0.3 animations:^{
        self.titleBottomView.centerX=btn.centerX;
        self.titleBottomView.width = btn.titleLabel.width;
    }];
    //scrollView也要滚动
    CGPoint contentOffset=self.scrollView.contentOffset;
    contentOffset.x=[self.titleBtns indexOfObject:btn] * self.view.width;
    [self.scrollView setContentOffset:contentOffset animated:YES];
//    self.scrollView.contentOffset=contentOffset;
}
#pragma mark ScrollView的代理方法
//设置contentOffSet必须得有动画 才会调用此方法.
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x / self.view.width;
    UIViewController * willShowVc = self.childViewControllers[index];
    willShowVc.view.frame = scrollView.bounds;
    [self.scrollView addSubview:willShowVc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    int index = scrollView.contentOffset.x / self.view.width;
    KYTitileButton * btn = self.titleBtns[index];
    [self titleBtnClick:btn];
}

@end
