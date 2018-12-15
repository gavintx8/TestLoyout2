//
//  GOpenAccountVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/9.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GOpenAccountVc.h"
#import <WebKit/WebKit.h>

@interface GOpenAccountVc ()<WKUIDelegate,WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *wkWebview;
@end

@implementation GOpenAccountVc

- (void)onCreate {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.navTitle;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"top_Back_nor"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"top_Back_pre"] forState:UIControlStateHighlighted];
    button.sz_size = CGSizeMake(70, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)back {
    if(self.regVc != nil){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:NO completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)onWillShow {
    [self.view addSubview:self.wkWebview];
    [self.wkWebview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.view addSubview:self.wkWebview];
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *basePath = [NSString stringWithFormat: @"%@", bundlePath];
    NSURL *baseUrl = [NSURL fileURLWithPath: basePath isDirectory: YES];
    NSString *indexPath = [NSString stringWithFormat: @"%@/%@", basePath,self.htmlName];
    NSString *indexContent = [NSString stringWithContentsOfFile:
                              indexPath encoding: NSUTF8StringEncoding error:nil];
    [self.wkWebview loadHTMLString: indexContent baseURL: baseUrl];
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

- (void)onWillDisappear {
    
}

@end
