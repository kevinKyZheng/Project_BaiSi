//
//  KYTabBarController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/1.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYTabBarController.h"
#import "KYEssenceController.h"
#import "KYFriendController.h"
#import "KYMeController.h"
#import "KYNewController.h"
#import "KYTabBar.h"
#import "KYNavigationController.h"
#import "KYAddTagViewController.h"

@implementation KYTabBarController
-(void)viewDidLoad
{
    //添加所有的TabbarItem
    [self settupAllTabbar];
    //添加自定义Tabbar
    [self setupTabBar];
    //设置TabbarItem的属性
    [self setupTabBarItem];
}
/**
 *  添加Tabbar
 */
-(void)settupAllTabbar
{
//    [self settupChildVcWithController:[[KYAddTagViewController alloc]init] andTitle:@"我" andImage:@"tabBar_me_icon" andSelectedImage:@"tabBar_me_click_icon"];
        [self settupChildVcWithController:[[KYFriendController alloc]init] andTitle:@"关注" andImage:@"tabBar_friendTrends_icon" andSelectedImage:@"tabBar_friendTrends_click_icon"];
    [self settupChildVcWithController:[[KYEssenceController alloc]init] andTitle:@"精华" andImage:@"tabBar_essence_icon" andSelectedImage:@"tabBar_essence_click_icon"];
        [self settupChildVcWithController:[[KYMeController alloc]initWithStyle:(UITableViewStyleGrouped)] andTitle:@"我" andImage:@"tabBar_me_icon" andSelectedImage:@"tabBar_me_click_icon"];
    [self settupChildVcWithController:[[KYNewController alloc]init] andTitle:@"新帖" andImage:@"tabBar_new_icon" andSelectedImage:@"tabBar_new_click_icon"];
    [self settupChildVcWithController:[[KYFriendController alloc]init] andTitle:@"关注" andImage:@"tabBar_friendTrends_icon" andSelectedImage:@"tabBar_friendTrends_click_icon"];

}
/**
 *  添加一个TabbarItem
 */
-(void)settupChildVcWithController:(UIViewController *)vc andTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage
{
    KYNavigationController * nav=[[KYNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
    
    nav.tabBarItem.title=title;
    nav.tabBarItem.image=[UIImage imageNamed:image];
    nav.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
}
/**
 *  添加自定义Tabbar
 */
-(void)setupTabBar
{
    [self setValue:[[KYTabBar alloc]init] forKeyPath:@"tabBar"];
}
/**
 *  设置TabBar属性
 */
-(void)setupTabBarItem
{
    //normal下的文字属性
    NSMutableDictionary * normalTextAttr=[NSMutableDictionary dictionary];
    normalTextAttr[NSForegroundColorAttributeName]=[UIColor grayColor];

    //selected下的文字属性
    NSMutableDictionary * selectedTextAttr=[NSMutableDictionary dictionary];
    selectedTextAttr[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    //设置
    UITabBarItem * item=[UITabBarItem appearance];
    [item setTitleTextAttributes:normalTextAttr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedTextAttr forState:UIControlStateSelected];
    
    
}
@end
