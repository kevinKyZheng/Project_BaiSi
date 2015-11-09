//
//  KYWebViewController.m
//  百思不得姐
//
//  Created by 郑开元 on 15/9/8.
//  Copyright (c) 2015年 郑开元. All rights reserved.
//

#import "KYWebViewController.h"

@interface KYWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBtn;

@end

@implementation KYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=self.square.name;
    self.webView.scrollView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    self.view.backgroundColor=KYBGColor;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.square.url]]];
}

- (IBAction)back {
    [self.webView goBack];
}
- (IBAction)forward {
    [self.webView goForward];
}
- (IBAction)refresh {
    [self.webView reload];
}
#pragma mark Delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backBtn.enabled=webView.canGoBack;
    self.forwardBtn.enabled=webView.canGoForward;
}
@end
