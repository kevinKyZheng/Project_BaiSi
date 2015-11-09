//
//  KYSeeBigPictureController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/17.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYSeeBigPictureController.h"
#import "KYTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface KYSeeBigPictureController ()<UIScrollViewDelegate>
@property(nonatomic,weak)UIImageView * imageView;
@end

@implementation KYSeeBigPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ScrollView
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    //说明:此处不能用self.view.bounds因为此处的bounds是xib中的bounds大小.
    scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate =self;
    [self.view insertSubview:scrollView atIndex:0];
    //imageView
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.image2]];
    imageView.x = 0;
    imageView.width = KYScreenW;
    imageView.height = imageView.width * self.topic.height /self.topic.width;
    if (imageView.height >= KYScreenH) {//大图
        imageView.y = 0;
        scrollView.contentSize = CGSizeMake(0, imageView.height);
    }else{
        imageView.centerY = KYScreenH * 0.5;
    }
    self.imageView = imageView;
    [scrollView addSubview:imageView];
    
    //设置ScrollView放大
    CGFloat maxScale = self.topic.height / imageView.height;
    if (maxScale > 1) {
        scrollView.maximumZoomScale =maxScale;
//        scrollView.bouncesZoom = NO;
    }
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}
#pragma mark - ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
@end
