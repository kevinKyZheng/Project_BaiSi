//
//  KYPostViewController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/9.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYPostViewController.h"
#import "KYPlaceHolderTextView.h"
#import "KYPulishWordToolBar.h"

@interface KYPostViewController ()<UITextViewDelegate>
@property(nonatomic,weak)KYPlaceHolderTextView * textView;
@property(nonatomic,weak)KYPulishWordToolBar * toolBar;
@end

@implementation KYPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;

    //设置Nav
    [self setupNav];
    //设置TextView
    [self setupTextView];
    //设置toolbar
    [self setupToolBar];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}
#pragma mark 初始化
-(void)setupToolBar
{
    KYPulishWordToolBar * toolBar=[KYPulishWordToolBar viewFromXib];
    toolBar.x=0;
    toolBar.y=self.view.height-toolBar.height;
    toolBar.width=self.view.width;
    self.toolBar=toolBar;
    [self.view addSubview:toolBar];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboadiWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)setupTextView
{
    KYPlaceHolderTextView * textView=[[KYPlaceHolderTextView alloc]init];
    textView.alwaysBounceVertical=YES;
    textView.frame=CGRectMake(0, 64, self.view.width, self.view.height);
    textView.delegate=self;
    textView.placeHolder=@"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    self.textView=textView;
    [self.view addSubview:textView];
}
-(void)setupNav
{
    self.title=@"发表文字";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发表" style:(UIBarButtonItemStylePlain) target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled=NO;
    [self.navigationController.navigationBar layoutIfNeeded];
}
#pragma mark NavItem的点击事件
- (void)post
{
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark TextView Delegate
-(void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled=textView.hasText;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark 监听键盘Frame改变
- (void)keyboadiWillChangeFrame:(NSNotification *)note
{
    CGFloat duration=[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:(duration) animations:^{
        CGFloat ty=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y-KYScreenH;
        self.toolBar.transform=CGAffineTransformMakeTranslation(0, ty);
    }];
}
@end
