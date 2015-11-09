//
//  KYAddTagViewController.h
//  百思不得姐
//
//  Created by 郑开元 on 15/9/11.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KYAddTagViewController : UIViewController
//向外传递数据
@property (nonatomic,copy)void(^getTagsBlock)(NSArray *);
//外部传递进来的数组
@property(nonatomic,strong)NSArray * tags;

@end
