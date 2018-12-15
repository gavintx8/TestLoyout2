//
//  GPayWebVc2.m
//  QuCai
//
//  Created by mac on 2017/10/15.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GPayWebVc2.h"
#import <WebKit/WebKit.h>
#import "JSONKit.h"

@interface GPayWebVc2 ()<UIWebViewDelegate>
@property (nonatomic, strong) WKWebView *wkWebview;
@end

@implementation GPayWebVc2

- (void)onCreate {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = self.navTitle;
    
    [SVProgressHUD showWithStatus:@"加载中，请稍后..."];
}

- (void)onWillShow {
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    webView.delegate = self;
    
    if(self.htmlurl == nil){
        [self.wkWebview loadHTMLString:self.htmlcontent baseURL:nil];
        [webView loadHTMLString:self.htmlcontent baseURL:nil];
    }else{
//        NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.htmlurl]];
//        [self.wkWebview loadRequest:request];
//
        NSURL *url = [[NSURL alloc] initWithString:self.htmlurl];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [webView loadRequest:request];
    }
}

//-(WKWebView *)wkWebview {
//    if (_wkWebview == nil) {
//        _wkWebview = [[WKWebView alloc] init];
//        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
//        config.preferences = [[WKPreferences alloc] init];
//        config.preferences.minimumFontSize = 10;
//        config.preferences.javaScriptEnabled = true;
//        self.wkWebview.backgroundColor = [UIColor whiteColor];
//        self.wkWebview.UIDelegate = self;
//        self.wkWebview.navigationDelegate = self;
//    }
//    return _wkWebview;
//}

//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//
//    NSString* scheme = [navigationAction.request.URL scheme];
//    NSURL *requestURL = [navigationAction.request URL];
//    NSString * urlStr = [requestURL absoluteString];
//
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kFilePath]];
//    NSDictionary *resultDict = [data objectFromJSONData];
//    NSArray *pays = [resultDict objectForKey:@"pay_url"];
//
//    if ( [scheme isEqualToString:@"https"]){
//
//        for (int i=0; i<[pays count]; i++) {
//
//            NSString *pay = [pays objectAtIndex:i];
//
//            if ([urlStr rangeOfString:pay].location != NSNotFound) {
//                if (@available(iOS 10.0, *)) {
//                    [[UIApplication sharedApplication] openURL:requestURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
//                    }];
//                } else {
//                    // Fallback on earlier versions
//                }
//                decisionHandler(WKNavigationActionPolicyCancel);
//                return ;
//            }
//        }
//    }
//    decisionHandler(WKNavigationActionPolicyAllow);
//}
//
//- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
//    [SVProgressHUD dismiss];
//}
//
//- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
//    [SVProgressHUD dismiss];
//}
//
//- (void)onWillDisappear {
//    [SVProgressHUD dismiss];
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* scheme = [[request URL] scheme];
    NSURL *requestURL =[ request URL ];
    
    NSString * urlStr = [requestURL absoluteString];
    NSLog(@"webView加载 %@",requestURL);
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kFilePath]];
    NSDictionary *resultDict = [data objectFromJSONData];
    NSArray *pays = [resultDict objectForKey:@"pay_url"];
    
    if ( [scheme isEqualToString:@"https"]){
        
        for (int i=0; i<[pays count]; i++) {
            
            NSString *pay = [pays objectAtIndex:i];
            
            if ([urlStr rangeOfString:pay].location != NSNotFound) {
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:requestURL options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                    }];
                } else {}
                return NO;
            }
        }
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
}

@end
