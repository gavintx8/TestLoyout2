//
//  ContactServiceVc.m
//  QuCai
//
//  Created by tx gavin on 2017/7/6.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "ContactServiceVc.h"
#import <WebKit/WebKit.h>
#import "YBPopupMenu.h"

#define TITLES @[@"8818862", @"jinshaff168888", @"8818862@qq.com"]
#define ICONS  @[@"icon-qq2",@"icon-wx2",@"icon-email2"]

@interface ContactServiceVc ()<WKUIDelegate,WKNavigationDelegate,YBPopupMenuDelegate>

@property (nonatomic, strong) WKWebView *wkWebview;

@end

@implementation ContactServiceVc

- (void)onCreate {
    
    [self setupNav];
    
    self.navigationItem.title = @"在线客服";
    
    [self.view addSubview:self.wkWebview];
    [self.wkWebview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kContactService]];
    [self.wkWebview loadRequest:request];
    [SVProgressHUD showWithStatus:@"加载中，请稍后..."];
}

- (void)setupNav {
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.sz_size = CGSizeMake(20, 30);
    [rightBtn setTitle:@"•••" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.f];
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
    
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

- (void)rightBtnClick:(UIButton *)sender {
    [YBPopupMenu showRelyOnView:sender titles:TITLES icons:ICONS menuWidth:190 delegate:self];
}

- (void)back {
    if (@available(iOS 10.0, *)) {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *controller = app.window.rootViewController;
        GTabBarVc *rvc = (GTabBarVc *)controller;
        [rvc setSelectedIndex:0];
    } else {}
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)onWillShow {
    self.navigationController.navigationBar.hidden = NO;
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

    //设置JS
    NSMutableString *inputValueJS = [NSMutableString string];
    [inputValueJS appendString:@"var goback = document.getElementsByClassName(\"goBack\")[0];"];
    [inputValueJS appendString:@"goback.style.display = 'none';"];
    //执行JS
    [webView evaluateJavaScript:inputValueJS completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    }];
    
    self.navigationController.navigationBar.hidden = NO;
    [SVProgressHUD dismiss];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [SVProgressHUD dismiss];
}

- (void)onWillDisappear {
    [SVProgressHUD dismiss];
}

#pragma mark - YBPopupMenuDelegate
- (void)ybPopupMenu:(YBPopupMenu *)ybPopupMenu didSelectedAtIndex:(NSInteger)index
{
    if(index == 0){
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",@"8818862"]]];
        }else{
            [SVProgressHUD showInfoWithStatus:@"请安装QQ"];
        }
    }
}

@end
