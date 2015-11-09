//
//  KYTabBar.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/1.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTabBar.h"
#import "KYPublishViewController.h"

@interface KYTabBar()
@property(nonatomic,weak)UIButton * publishBtn;
@end

@implementation KYTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.backgroundImage=[UIImage imageNamed:@"tabbar-light"];
        //设置发布按钮
        UIButton * publishBtn=[UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateSelected)];
        [publishBtn sizeToFit];
        [publishBtn addTarget:self action:@selector(publishBtnPress) forControlEvents:(UIControlEventTouchUpInside)];
        self.publishBtn=publishBtn;
        [self addSubview:publishBtn];
    }
    return self;
}
-(void)publishBtnPress
{
    KYPublishViewController *pulishVc=[[KYPublishViewController alloc]init];
    [self.window.rootViewController presentModalViewController:pulishVc animated:NO];
}
/**
 *  布局子控件
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    //发布按钮的尺寸
    self.publishBtn.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    //tabBarItem的尺寸
    CGFloat tabBarBtnW=self.frame.size.width/5;
    CGFloat tabBarBtnH=self.frame.size.height;
    CGFloat tabBarBtnY=0;
    
    int index=0;
    
    for (UIView * tabBarButtonItem in self.subviews) {
        if (![NSStringFromClass(tabBarButtonItem.class) isEqualToString:@"UITabBarButton"]) continue;
        CGFloat tabBarBtnX=index*tabBarBtnW;
        if (index>=2) {
            tabBarBtnX+=tabBarBtnW;
        }
        tabBarButtonItem.frame=CGRectMake(tabBarBtnX, tabBarBtnY, tabBarBtnW, tabBarBtnH);
        index++;
    }
}
@end
