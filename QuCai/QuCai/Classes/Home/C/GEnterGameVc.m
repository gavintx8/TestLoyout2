//
//  GEnterGameVc.m
//  QuCai
//
//  Created by tx gavin on 2017/6/25.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GEnterGameVc.h"

@interface GEnterGameVc ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebview;

@end

@implementation GEnterGameVc

- (void)onCreate {
    
    self.navigationItem.title = @"游戏";
    
    [self.view addSubview:self.wkWebview];
    [self.wkWebview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    NSString* urlPath = self.urlStr;
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlPath]];
    [self.wkWebview loadRequest:request];
    [self.view addSubview:self.wkWebview];
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

-(WKWebView *)wkWebview {
    if (_wkWebview == nil) {
        _wkWebview = [[WKWebView alloc] init];
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences = [[WKPreferences alloc] init];
        config.preferences.minimumFontSize = 10;
        config.preferences.javaScriptEnabled = true;
        self.wkWebview.backgroundColor = [UIColor whiteColor];
        self.wkWebview.UIDelegate = self;
        self.wkWebview.navigationDelegate = self;
    }
    return _wkWebview;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [SVProgressHUD dismiss];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
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
