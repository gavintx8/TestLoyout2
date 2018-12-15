//
//  AppDelegate.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "AppDelegate.h"
#import "GLoginVC.h"
#import "GQKeyboardManager.h"
#import <AFNetworkActivityLogger.h>
//#import <Bugtags/Bugtags.h>
#import "UIAlertController+HUtil.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@property (nonatomic, strong) GTabBarVc *gTabBarVc;
@property (nonatomic, strong) GLoginVC *gLogin;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [Bugtags startWithAppKey:@"1d0ab04404cf6e1c0653bcd984ec2c62" invocationEvent:BTGInvocationEventBubble];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    
    GQKeyboardManager * gqkb = [GQKeyboardManager share];
    gqkb.enable = YES;
    gqkb.enableAutoToolbar = YES;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [[UITabBar appearance] setTranslucent:NO];
    //监测网络环境
    [self AFNReachability];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    GTabBarVc *rootVc = [[GTabBarVc alloc] init];
    self.rootVc = rootVc;
    rootVc.delegate = self;
    self.window.rootViewController = rootVc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

    if (tabBarController.selectedIndex == 3) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
         
            GLoginVC *gLogin = [[GLoginVC alloc] init];
            self.gLogin = gLogin;
            [(tabBarController.selectedViewController) presentViewController:gLogin animated:YES completion:nil];
        }
    }
}

//使用AFN框架来检测网络状态的改变
- (void)AFNReachability {
    
    //2.监听网络状态的改变
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                [UIAlertController showAlertWithTitle:@"系统提示" message:@"当前为未知网络！" style:UIAlertControllerStyleAlert cancelButtonTitle:@"确定" otherButtonTitles:nil completion:nil];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [UIAlertController showAlertWithTitle:@"系统提示" message:@"当前无网络！" style:UIAlertControllerStyleAlert cancelButtonTitle:@"确定" otherButtonTitles:nil completion:nil];
                break;
                
            default:
                break;
        }
    }];
    
    //3.开始监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {
   
}

@end
