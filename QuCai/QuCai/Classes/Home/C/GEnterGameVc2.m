//
//  GEnterGameVc2.m
//  QuCai
//
//  Created by mac on 2017/10/14.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GEnterGameVc2.h"

@interface GEnterGameVc2 ()<UIWebViewDelegate>

//@property (nonatomic, strong) UIWebView *webView;

@end

@implementation GEnterGameVc2

- (void)onCreate {
    
    self.navigationItem.title = @"游戏";
    
    NSString* urlPath = self.urlStr;
    
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    webView.delegate = self;

    //加载非本地网页
    NSURL *url = [[NSURL alloc] initWithString:urlPath];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [webView loadRequest:request];
}

- (void)onWillShow {
    [SVProgressHUD showWithStatus:@"加载中，请稍后..."];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"enterGame"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (![UIDevice currentDevice].generatesDeviceOrientationNotifications) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationChange:)
                                                name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
}

- (void)onWillDisappear {
    [SVProgressHUD dismiss];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"enterGame"];
    [userDefaults synchronize];
}

- (void)handleDeviceOrientationChange:(NSNotification *)notification{
    
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    switch (deviceOrientation) {
        case UIDeviceOrientationLandscapeLeft:
        {
            [self.navigationController setNavigationBarHidden:YES];
        }
            break;
        case UIDeviceOrientationLandscapeRight:
        {
            [self.navigationController setNavigationBarHidden:YES];
        }
            break;
        case UIDeviceOrientationPortrait:
        {
            [self.navigationController setNavigationBarHidden:NO];
        }
            break;
        default:
            break;
    }
}


@end
