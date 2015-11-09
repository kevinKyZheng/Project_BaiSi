//
//  KYPublishViewController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/9.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYPublishViewController.h"
#import "KYPublishButton.h"
#import "KYPostViewController.h"
#import <POP.h>
#import "KYNavigationController.h"

@interface KYPublishViewController ()
@property(nonatomic,weak)UILabel * slogenView;
//按钮
@property(nonatomic,strong)NSMutableArray * buttons;
//时间间隔
@property(nonatomic,strong)NSArray * times;

@end

@implementation KYPublishViewController

#pragma mark 懒加载
-(NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons=[NSMutableArray array];
    }
    return _buttons;
}
-(NSArray *)times
{
    if (!_times) {
        CGFloat interval = 0.1;
        _times = @[@(5 * interval),
                   @(4 * interval),
                   @(3 * interval),
                   @(2 * interval),
                   @(1 * interval),
                   @(0 * interval),
                   @(6 * interval)];//slogan的动画时间
    }
    return _times;
}
#pragma mark 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSlogen];
    [self setupBtn];
    
}
//设置Slogan
-(void)setupSlogen
{
    //背景
    UIImageView * slogenView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    slogenView.y=KYScreenH*0.2-KYScreenH;
    slogenView.centerX=KYScreenW*0.5;
    self.slogenView=slogenView;
    [self.view addSubview:slogenView];
    //设置动画
    POPSpringAnimation * anima = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anima.toValue=@(KYScreenH*0.2);
    anima.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
    anima.springBounciness = 15;
    anima.springSpeed = 20;
    [slogenView.layer pop_addAnimation:anima forKey:nil];
}
//设置button
-(void)setupBtn
{
    //按钮
    NSArray * images=[NSArray arrayWithObjects:@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline", nil];
    NSArray * texts=[NSArray arrayWithObjects:@"发视频",@"发图片",@"发段子",@"发声音",@"审贴",@"离线下载", nil];
    //个数,行数,列数
    NSUInteger count=texts.count;
    NSInteger numberOfCollum=3;
    NSInteger numberOfRow=(count+numberOfCollum-1)/numberOfCollum;
    //计算Frame
    CGFloat buttonW=KYScreenW/numberOfCollum;
    CGFloat buttonH=buttonW;
    CGFloat buttonStartY=(KYScreenH-numberOfRow*buttonH)*0.5;
    for (int i=0; i<count; i++) {
        KYPublishButton * button=[KYPublishButton buttonWithType:UIButtonTypeCustom];
        [self.buttons addObject:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        CGFloat buttonX=(i%numberOfCollum)*buttonW;
        CGFloat buttonY=(i/numberOfCollum)*buttonH+buttonStartY;
        //设置动画
        POPSpringAnimation * anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anima.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY-KYScreenH, buttonW, buttonH)];
        anima.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonY, buttonW, buttonH)];
        anima.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        anima.springBounciness = 15;
        anima.springSpeed = 20;
        [button pop_addAnimation:anima forKey:nil];
        
        //设置image和title
        [button setImage:[UIImage imageNamed:images[i]] forState:(UIControlStateNormal)];
        [button setTitle:texts[i] forState:(UIControlStateNormal)];
        [self.view addSubview:button];
    }
}
//退出动画
-(void)exit:(void(^)())task
{
    //按钮执行动画
    for (int i=0; i<self.buttons.count; i++) {
        KYPublishButton * btn = self.buttons[i];
        POPBasicAnimation * anima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
        anima.toValue = @(btn.y + KYScreenH);
        anima.beginTime = CACurrentMediaTime() + [self.times[i] doubleValue];
        [btn.layer pop_addAnimation:anima forKey:nil];
    }
    //标签执行动画
    POPBasicAnimation * anima = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anima.toValue = @(self.slogenView.y + KYScreenH);
    anima.beginTime = CACurrentMediaTime() + [[self.times lastObject] doubleValue];
    [anima setCompletionBlock:^(POPAnimation * anima, BOOL finish) {
        [self dismissViewControllerAnimated:NO completion:nil];
        if (task) task();
    }];
    [self.slogenView pop_addAnimation:anima forKey:nil];
}
/**
 *  按钮点击事件
 *
 *  @param btn 点击的按钮
 */
-(void)buttonClick:(KYPublishButton *)btn
{
    [self exit:^{
        NSUInteger index=[self.buttons indexOfObject:btn];
        KYPostViewController * postVc=[[KYPostViewController alloc]init];
        if (index==2) {
            [self.view.window.rootViewController presentViewController:[[KYNavigationController alloc] initWithRootViewController:postVc] animated:YES completion:nil];
        }
    }];
}
//取消按钮
- (IBAction)cancel:(id)sender {
    [self exit:nil];
}
//点击屏幕取消
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self exit:nil];
}
@end
