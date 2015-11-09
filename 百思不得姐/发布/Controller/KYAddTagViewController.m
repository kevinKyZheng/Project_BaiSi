//
//  KYAddTagViewController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/11.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYAddTagViewController.h"
#import "KYTagButton.h"
#import "KYTagTextField.h"
#import <SVProgressHUD.h>

@interface KYAddTagViewController () <UITextFieldDelegate>

//存放所有内容的view
@property(nonatomic,weak)UIView * contentView;
//文本框
@property(nonatomic,weak)KYTagTextField * textField;
//提示框
@property(nonatomic,weak)UIButton * tipBtn;
//标签数组
@property(nonatomic,strong)NSMutableArray * tagBtns;

@end

@implementation KYAddTagViewController
#pragma mark - 懒加载
//标签数组
- (NSMutableArray *)tagBtns
{
    if (_tagBtns == nil) {
        _tagBtns = [NSMutableArray array];
    }
    return _tagBtns;
}
//提示框
- (UIButton *)tipBtn
{
    if (_tipBtn == nil) {
        //添加提示框
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [btn setBackgroundColor:KYTagBgColor];
        //设置Frame
        btn.x = 0;
        btn.width = self.contentView.width;
        btn.height = KYTagHeight;
        //设置文字属性
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, KYSmallMargin, 0, 0);
        [btn addTarget:self action:@selector(tipBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.contentView addSubview: btn];
        _tipBtn = btn;
    }
    return _tipBtn;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupContentView];
    [self setupTextView];
    [self setupTag];
}
//默认显示的标签
- (void)setupTag
{
    for (NSString * tag in self.tags) {
        self.textField.text = tag;
        [self tipBtnClick];
    }
}
//设置Nav
- (void)setupNav
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:(UIBarButtonItemStyleDone) target:self action:@selector(done)];
}
//取消按钮
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//完成按钮
- (void)done
{
    NSArray * tags = [self.tagBtns valueForKeyPath:@"currentTitle"];
    !self.getTagsBlock ? : self.getTagsBlock(tags);
    [self dismissViewControllerAnimated:YES completion:nil];
}
//设置ContentView
- (void)setupContentView
{
    UIView * contentView = [[UIView alloc]init];
    
    contentView.x = KYSmallMargin;
    contentView.y = KYNavHeight + KYSmallMargin;
    contentView.width = self.view.width - 2 * KYSmallMargin;
    contentView.height = self.view.height;
    self.contentView = contentView;
    [self.view addSubview:contentView];
}
//设置TextView
- (void)setupTextView
{
    KYWeakSelf
    KYTagTextField * textField = [[KYTagTextField alloc]init];
    //设置Frame
    textField.x = 0;
    textField.y = 0;
    textField.width = self.contentView.width;
    textField.height = KYTagHeight;
    
    //设置占位文字
    textField.placeholder = @"输入,或者换行完成输入";
    textField.placeHolderColor = [UIColor lightGrayColor];
    [textField addTarget:self action:@selector(textChange) forControlEvents:(UIControlEventEditingChanged)];
    textField.delegate = self;
    [self.contentView addSubview:textField];
    self.textField = textField;
    
    //自动呼出键盘
    [textField becomeFirstResponder];
    //有时候会发生焦点抢夺,所以需要重新刷新下才能显示光标
    [textField layoutIfNeeded];
    
    //点击删除需要的操作
    textField.deleteBackOpertion = ^{
        if (weakSelf.textField.hasText || weakSelf.tagBtns.count == 0) {
            return;
        }
        [weakSelf tagBtnClick:weakSelf.tagBtns.lastObject];
    };
    
}
#pragma mark 监听点击
//监听文本框文字的改变
- (void)textChange
{
    if (!self.textField.hasText) {
        self.tipBtn.hidden = YES;
    }else{
        //判断是不是逗号
        NSString * text = self.textField.text;
        NSString * lastChar = [text substringFromIndex:text.length - 1];
        if ([lastChar isEqualToString:@","]) {//是,
            self.textField.text = [text substringToIndex:text.length - 1];
            [self tipBtnClick];
        }else{//不是,
            //调整文本框位置
            [self setTextFieldFrame];
            //设置提示框
            self.tipBtn.hidden = NO;
            [self.tipBtn setTitle:[NSString stringWithFormat:@"添加标签:%@",self.textField.text ] forState:(UIControlStateNormal)];
        }
    }
}
//提示按钮的点击事件
- (void)tipBtnClick
{
    if (self.textField.hasText == NO) return;
    //1.生成标签 2.调整placeholder位置
    //标签按钮
    if (self.tagBtns.count == 5) {
        [SVProgressHUD showErrorWithStatus:@"最多输入五个标签" maskType:(SVProgressHUDMaskTypeBlack)];
        return;
    }
    KYTagButton * newTagBtn =[KYTagButton buttonWithType:(UIButtonTypeCustom)];
    [newTagBtn setTitle:self.textField.text forState:(UIControlStateNormal)];
    [newTagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:newTagBtn];
    //设置Frame
    
    KYTagButton * lastTagBtn = [self.tagBtns lastObject];
    if (lastTagBtn) {
        CGFloat maxX = CGRectGetMaxX(lastTagBtn.frame);
        CGFloat rightWidth = self.contentView.width -maxX;
        if (rightWidth > newTagBtn.width) {//不需要换行
            newTagBtn.x = maxX + KYSmallMargin;
            newTagBtn.y = lastTagBtn.y;
        }else{
            newTagBtn.x = 0;
            newTagBtn.y = CGRectGetMaxY(lastTagBtn.frame) + KYSmallMargin;
        }
    }else{//第一个按钮
        newTagBtn.origin =CGPointMake(0, 0);
    }
    [self.tagBtns addObject:newTagBtn];
    //调整placeholder位置
    self.textField.text = nil;
    [self setTextFieldFrame];
    //隐藏提醒按钮
    self.tipBtn.hidden = YES;
}
/** 点击标签按钮 删除 */
- (void)tagBtnClick:(KYTagButton *)tagClickedBtn
{
    //记住要删除的索引
    NSUInteger index = [self.tagBtns indexOfObject:tagClickedBtn];
    //删除
    [tagClickedBtn removeFromSuperview];
    [self.tagBtns removeObject:tagClickedBtn];
    //处理后面的标签
    for (NSUInteger i = index; i < self.tagBtns.count; i++) {
        //删除之后,index变成后面的按钮
        KYTagButton * rejustBtn = self.tagBtns[i];
        KYTagButton * previousBtn = (i == 0)? nil :
        self.tagBtns[i-1];
        [self setRejustBtnFrame:rejustBtn refrenceBtn:previousBtn];
    }
    [self setTextFieldFrame];
}

#pragma mark 调整Frame
- (void)setRejustBtnFrame:(KYTagButton *)rejustBtn refrenceBtn:(KYTagButton *)refrenceBtn
{
    //删除的是第一个标签
    if (refrenceBtn == nil) {
        rejustBtn.x = 0;
        rejustBtn.y = 0;
        return;
    }
    //删除的不是第一个标签
    CGFloat leftWidth = CGRectGetMaxX(refrenceBtn.frame) + KYSmallMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    if (rejustBtn.width <= rightWidth) {//同一行
        rejustBtn.y = refrenceBtn.y;
        rejustBtn.x = leftWidth;
    }else{//不同行
        rejustBtn.x = 0;
        rejustBtn.y = CGRectGetMaxY(refrenceBtn.frame) + KYSmallMargin;
    }
}
- (void)setTextFieldFrame
{
    //排布文本框
    CGFloat textWidth = [self.textField.text sizeWithAttributes:@{NSFontAttributeName : self.textField.font}].width;
    KYTagButton * lastBtn = [self.tagBtns lastObject];
    
    textWidth = MAX(textWidth, 100);
    
    CGFloat leftWidth = CGRectGetMaxX(lastBtn.frame)+ KYSmallMargin;
    CGFloat rightWidth = self.contentView.width - leftWidth;
    if (lastBtn == nil) {
        self.textField.x = 0;
        self.textField.y = 0;
    }else{
        if (rightWidth >= textWidth) { //同一行
            self.textField.x = leftWidth + KYSmallMargin;
            self.textField.y = lastBtn.y;
        }else{
            self.textField.x = 0;
            self.textField.y = CGRectGetMaxY(lastBtn.frame) + KYSmallMargin;
        }
    }
    //排布提示栏
    self.tipBtn.y = CGRectGetMaxY(self.textField.frame);

}
#pragma mark TextField 的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tipBtnClick];
    return YES;
}
@end
