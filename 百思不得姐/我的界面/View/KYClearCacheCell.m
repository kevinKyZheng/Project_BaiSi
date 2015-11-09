//
//  KYClearCacheCell.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/8.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYClearCacheCell.h"
#import "NSString+KYFileCache.h"
#import "KYTool.h"
#define KYCacheFile [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
static NSString * const CacheText=@"清除缓存";
@implementation KYClearCacheCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //设置转圈
        UIActivityIndicatorView * activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        [activityView startAnimating];
        self.accessoryView=activityView;
        //
        self.textLabel.text=CacheText;
        //计算缓存大小
        [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
            //            [NSThread sleepForTimeInterval:3];
            NSString * path=(NSString *)[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] ;
            
            NSInteger size = path.fileCache;
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            //            self.textLabel.text=CacheText;
            NSString * text=[NSString stringWithFormat:@"%@(%@)",CacheText,[KYTool sizeToString:size]];
            //刷新控件
            [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                self.textLabel.text=text;
                self.accessoryView=nil;
                self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            }];
        }];
    }
    return self;
}
/**
 *  更新状态
 */
-(void)updateStatus
{
    if (self.accessoryView==nil)return;
    UIActivityIndicatorView * acttivityView=(UIActivityIndicatorView *)self.accessoryView;
    [acttivityView startAnimating];
}
/**
 *  清空缓存
 */
-(void)clearCache
{
    [SVProgressHUD showWithStatus:@"正在清除缓存"];
    //    dispatch_async(dispatch_get_global_queue(@"clear", 0) , ^{
    //        [[NSFileManager defaultManager]removeItemAtPath:KYCacheFile error:nil];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
    //            self.textLabel.text=CacheText;
    //        })
    //    });
    [[[NSOperationQueue alloc]init]addOperationWithBlock:^{
        [NSThread sleepForTimeInterval:2];
//        [[NSFileManager defaultManager]removeItemAtPath:KYCacheFile error:nil];
        NSLog(@"%@",KYCacheFile);
        //刷新控件
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [SVProgressHUD showSuccessWithStatus:@"清除成功"];
            self.textLabel.text=CacheText;
        }];
    }];
    
}
@end
