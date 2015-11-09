//
//  KYPulishWordToolBar.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/11.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYPulishWordToolBar.h"
#import "KYPostViewController.h"
#import "KYNavigationController.h"
#import "KYAddTagViewController.h"

@interface KYPulishWordToolBar ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property(nonatomic,strong)NSMutableArray * tags;
@property(nonatomic,weak)UIButton * plusBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;
@end

@implementation KYPulishWordToolBar
-(NSMutableArray *)tags
{
    if (_tags == nil) {
        _tags = [NSMutableArray array];
    }
    return _tags;
}
-(void)awakeFromNib
{
    UIButton * btn=[UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn addTarget:self action:@selector(tagBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [btn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:(UIControlStateNormal)];
    [btn sizeToFit];
    self.plusBtn = btn;
    [self.topView addSubview:btn];
    
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    [self creatTagsLabel:@[@"吐槽",@"糗事"]];

}
- (void)tagBtnClick
{
    KYWeakSelf
    KYAddTagViewController * addTagVc=[[KYAddTagViewController alloc]init];
    KYNavigationController * nav=[[KYNavigationController alloc]initWithRootViewController:addTagVc];
    
    addTagVc.getTagsBlock = ^(NSArray * tags){
        [weakSelf creatTagsLabel:tags];
    };
    
    addTagVc.tags = [self.tags valueForKeyPath:@"text"];
    
    KYPostViewController * postVc=(KYPostViewController *)self.window.rootViewController.presentedViewController;
    [postVc presentViewController:nav animated:YES completion:nil];

}
/**
 *  创建标签
 *
 *  @param tags 每个标签的文字
 */
- (void)creatTagsLabel:(NSArray *)tags
{
    //清空数组
    [self.tags makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tags removeAllObjects];
    //创建标签
    for (int i = 0; i < tags.count; i++) {
        UILabel * label = [[UILabel alloc]init];
        label.backgroundColor = KYTagBgColor;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = tags[i];
        
        [label sizeToFit];
        label.height = KYTagHeight;
        label.width += 3 * KYSmallMargin;
        
        [self.topView addSubview:label];
        [self.tags addObject:label];
        
        //计算位置
        if (i == 0) {
            label.x = 0;
            label.y = 0;
        }else{
            UILabel * previousLabel = self.tags[i -1];
            CGFloat leftW = CGRectGetMaxX(previousLabel.frame) + KYSmallMargin;
            CGFloat rightW = self.width - leftW;
            if (rightW >= label.width) {//不换行
                label.x = leftW;
                label.y = previousLabel.y;
            }else{//换行
                label.x =0 ;
                label.y = CGRectGetMaxY(previousLabel.frame) + KYSmallMargin;
            }
        }
    }
    //调整加号按钮的位置
    UILabel * lastLabel = self.tags.lastObject;
    if (lastLabel) {
        CGFloat leftW = CGRectGetMaxX(lastLabel.frame) + KYSmallMargin;
        CGFloat rightW = self.width - leftW;
        if (rightW >= self.plusBtn.width) {
            self.plusBtn.x = leftW;
            self.plusBtn.y = lastLabel.y;
        }else{
            self.plusBtn.x = 0;
            self.plusBtn.y = CGRectGetMaxY(lastLabel.frame) + KYSmallMargin;
        }
    }else{
        self.plusBtn.x = 0;
        self.plusBtn.y = 0;
    }
    //调整工具栏的告诉
    self.topViewHeight.constant = CGRectGetMaxY(self.plusBtn.frame);
    CGFloat oldHeight = self.height;
    self.height =  self.bottomView.height + KYSmallMargin + self.topViewHeight.constant;
    self.y -= self.height - oldHeight;
}
@end
