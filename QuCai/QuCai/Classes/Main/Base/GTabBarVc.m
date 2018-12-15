//
//  GTabBarVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GTabBarVc.h"
#import "GBaseVc.h"
#import "GHomeController.h"
#import "GServiceVc.h"
#import "GRegisterVc.h"
#import "GNavigationC.h"
#import "GCategoryVc.h"
#import "GTabBar.h"
#import "GLoginVC.h"
#import "GPayVc.h"
#import "JSONKit.h"
#import "HUpdate.h"

@interface GTabBarVc () <GTabBarDelegate,UITabBarDelegate>

@end

@implementation GTabBarVc

+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor colorWithRed:151.0/255 green:161.0/255 blue:161.0/255 alpha:1];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = BG_Nav;
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupChildVcs];
    
    self.gTabBar = [[GTabBar alloc] init];
    self.gTabBar.myDelegate = self;
    self.gTabBar.delegate = self;
    [self setValue:self.gTabBar forKeyPath:@"tabBar"];
    self.selectedIndex = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabBarItem) name:@"CHANGETABBARITEMTOZERO" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTabBarItem1) name:@"CHANGETABBARITEMTOVIPCENTER" object:nil];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:kFilePath]];
    NSDictionary *resultDict = [data objectFromJSONData];
    if (resultDict.count > 0) {
        NSString *app_url = [NSString stringWithFormat:@"%@",[resultDict objectForKey:@"navture_url"]];
        [[SZUser shareUser] saveBaseLink:app_url];
        NSString *h5_url = [NSString stringWithFormat:@"%@",[resultDict objectForKey:@"app_url"]];
        NSString *urlStr = [h5_url stringByReplacingOccurrencesOfString:@"?app=true" withString:@""];
        [[SZUser shareUser] saveH5Link:urlStr];
        NSString *plat_code = [NSString stringWithFormat:@"%@",[resultDict objectForKey:@"plat_code"]];
        [[SZUser shareUser] savePlatCodeLink:plat_code];
        NSString *src1 = [NSString stringWithFormat:@"%@",[resultDict objectForKey:@"src1"]];
        [[SZUser shareUser] saveSrc1Link:src1];
        
        //版本更新
        [HUpdate share].version  = [resultDict objectForKey:@"versionname"];
        [HUpdate share].isUpdate = [resultDict objectForKey:@"update"];
        [HUpdate share].downUrl  = [resultDict objectForKey:@"ios_download"];
        [HUpdate share].content  = [resultDict objectForKey:@"content"];
        [[HUpdate share] update];

    }
}

- (void)setupChildVcs {
    
    [self setupChildVc:[[GHomeController alloc] init] title:TABBAR_HOMEPAGE normalImage:TABBAR_HOMEPAGE_ICON selectedImg:TABBAR_HOMEPAGE_ICONH];
    
    [self setupChildVc:[[GCategoryVc alloc] init] title:TABBAR_CATEGORY normalImage:TABBAR_HOMEPAGE_CATEGORY selectedImg:TABBAR_HOMEPAGE_CATEGORYH];

    [self setupChildVc:[[GServiceVc alloc] init] title:TABBAR_SERVICE normalImage:TABBAR_SERVICE_ICON selectedImg:TABBAR_SERVICE_ICONH];
    
    [self modifyMemberTitle];
}

- (void)modifyMemberTitle{
    self.vipVc = [[GVIPCenterVc alloc] init];
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
        [self setupChildVc:self.vipVc title:TABBAR_LOGIN normalImage:TABBAR_VIPCENTER_ICON selectedImg:TABBAR_VIPCENTER_ICONH];
    }else{
        [self setupChildVc:self.vipVc title:TABBAR_VIPCENTER normalImage:TABBAR_VIPCENTER_ICON selectedImg:TABBAR_VIPCENTER_ICONH];
    }
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title normalImage:(NSString *)normalImg selectedImg:(NSString *)selectedImg {
    
    GNavigationC *gN = [[GNavigationC alloc] initWithRootViewController:vc];
    gN.navigationBar.barTintColor = BG_Nav;
    gN.navigationBar.backgroundColor = BG_Nav;
    gN.navigationBar.barStyle = UIBarStyleBlack;
    [self addChildViewController:gN];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:normalImg];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)tabBarPlusClick:(GTabBar *)tabBar {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {

        GRegisterVc *plusVC = [[GRegisterVc alloc] init];
        GNavigationC *navVc = [[GNavigationC alloc] initWithRootViewController:plusVC];
        [self presentViewController:navVc animated:NO completion:nil];
    } else {
        GPayVc *payVc = [[GPayVc alloc] init];
        GNavigationC *navVc = [[GNavigationC alloc] initWithRootViewController:payVc];
        [self presentViewController:navVc animated:NO completion:nil];
    }
}

- (void)changeTabBarItem {
    
    self.selectedIndex = 0;
}

- (void)changeTabBarItem1 {
    
    self.selectedIndex = 3;
}

- (BOOL)shouldAutorotate {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"enterGame"] != nil) {
        
        return YES;
    }else{
        return NO;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if ([userDefaults objectForKey:@"enterGame"] != nil) {
        
        return UIInterfaceOrientationMaskAll;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if([item.title isEqualToString:@"分类"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"leftCurrentIndex"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
