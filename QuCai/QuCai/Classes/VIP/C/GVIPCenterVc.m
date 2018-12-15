//
//  GVIPCenterVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GVIPCenterVc.h"
#import "AppDelegate.h"
#import "GTabBarVc.h"
#import "GTitleIconAction.h"
#import "GHandleView.h"
#import "GCheckView.h"
#import "JSONKit.h"
#import "GPayVc.h"
#import "GHelpVc.h"
#import "GCapitalFundVc.h"
#import "GTransferAccountsVc.h"
#import "GDrawMoneyVc.h"
#import "GJournalAccountCapitalVc.h"
#import "GBetRecordVc.h"
#import "GRechargeRecordVc.h"
#import "GTransferRecordVc.h"
#import "GDrawRecordVc.h"
#import "GAccountInfoVc.h"
#import "GSafeSettingVc.h"
#import "GNewActivityVc.h"

@interface GVIPCenterVc ()

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UILabel *balanceLabel;

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *handleMenus;
@property (nonatomic, strong) NSArray *checkMenus;

@end

@implementation GVIPCenterVc

- (NSArray *)handleMenus{
    if (!_handleMenus) {
        _handleMenus = @[
                       [GTitleIconAction titleIconWith:@"转账" icon:[UIImage imageNamed:@"user_icon_01"] controller:nil tag:0],
                       [GTitleIconAction titleIconWith:@"提款" icon:[UIImage imageNamed:@"user_icon_02"] controller:nil tag:1],
                       [GTitleIconAction titleIconWith:@"存款" icon:[UIImage imageNamed:@"user_icon_03"] controller:nil tag:2],
                       ];
    }
    return _handleMenus;
}

- (NSArray *)checkMenus{
    if (!_checkMenus) {
        _checkMenus = @[
                       [GTitleIconAction titleIconWith:@"资金流水" icon:[UIImage imageNamed:@"user_icon_04"] controller:nil tag:0],
                       [GTitleIconAction titleIconWith:@"投注记录" icon:[UIImage imageNamed:@"user_icon_05"] controller:nil tag:1],
                       [GTitleIconAction titleIconWith:@"充值记录" icon:[UIImage imageNamed:@"user_icon_06"] controller:nil tag:2],
                       [GTitleIconAction titleIconWith:@"转账记录" icon:[UIImage imageNamed:@"user_icon_07"] controller:nil tag:3],
                       [GTitleIconAction titleIconWith:@"提款记录" icon:[UIImage imageNamed:@"user_icon_08"] controller:nil tag:4],
                       [GTitleIconAction titleIconWith:@"账户信息" icon:[UIImage imageNamed:@"user_icon_09"] controller:nil tag:5],
                       [GTitleIconAction titleIconWith:@"安全设置" icon:[UIImage imageNamed:@"user_icon_10"] controller:nil tag:6],
                       [GTitleIconAction titleIconWith:@"优惠活动" icon:[UIImage imageNamed:@"user_icon_11"] controller:nil tag:7],
                       [GTitleIconAction titleIconWith:@"帮助中心" icon:[UIImage imageNamed:@"user_icon_12"] controller:nil tag:8],
                       [GTitleIconAction titleIconWith:@"退出账户" icon:[UIImage imageNamed:@"user_icon_13"] controller:nil tag:9],
                       [GTitleIconAction titleIconWith:@"" icon:[UIImage imageNamed:@""] controller:nil tag:10],
                       [GTitleIconAction titleIconWith:@"" icon:[UIImage imageNamed:@""] controller:nil tag:11],
                       ];
    }
    return _checkMenus;
}

- (void)onCreate {
    
    [self createUI];
}

- (void)onWillShow {
    self.navigationController.navigationBar.hidden = YES;
    
    self.balanceLabel.text = [GTool stringMoneyFamat:[[SZUser shareUser] readBalance]];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
        [self loadData];
    }
}

- (void)dealloc {

}

- (void)loadData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self searchBalance];
        }else{
            NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
            dicInfo[@"tname"] = [SZUser shareUser].readUser.userName;
            dicInfo[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
            NSString *pwd = [SZUser shareUser].readUser.password;
            dicInfo[@"tpwd"] = pwd;
            dicInfo[@"savelogin"] = @"1";
            dicInfo[@"isImgCode"] = @"0";
            
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kLogin RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
                SZUser *user = [SZUser shareUser];
                if ([responseObject[@"status"] isEqualToString:@"ok"]) {
                    
                    user.userKey = responseObject[@"userKey"];
                    user.userName = responseObject[@"userName"];
                    if (responseObject[@"balance"] == nil) {
                        user.balance = @"0.00";
                    } else {
                        user.balance = responseObject[@"balance"];
                        [[SZUser shareUser] saveBalance2:[NSString stringWithFormat:@"%@",responseObject[@"balance"]]];
                    }
                    user.integral = responseObject[@"integral"];
                    user.password = pwd;
                    [[SZUser shareUser] deleteUser];
                    [[SZUser shareUser] saveLogin];
                    [[SZUser shareUser] saveUser];
                    [self searchBalance];
                } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)searchBalance{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"BType"] = @"WALLET";
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetBalance RequestWay:kPOST withParamters:dict withToken:nil success:^(BOOL isSuccess, id responseObject) {
        NSDictionary *dict = [[NSDictionary alloc] init];
        dict = responseObject;
        if([dict objectForKey:@"balance"] != nil){
            [[SZUser shareUser] saveBalance2:[NSString stringWithFormat:@"%@",[dict objectForKey:@"balance"]]];
            self.balanceLabel.text = [GTool stringMoneyFamat:[[SZUser shareUser] readBalance]];
        }
        NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetUserInfo RequestWay:kPOST withParamters:dict2 withToken:nil success:^(BOOL isSuccess, id responseObject) {
            
            NSDictionary *dic = [[NSDictionary alloc] init];
            dic = responseObject;
            if (dic != nil) {
                self.usernameLabel.text = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"username"]] stringByReplacingOccurrencesOfString:@"tas" withString:@""];
            }
            [SVProgressHUD dismiss];
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:kNetError];
        }];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)createUI{
    self.view.backgroundColor = Them_Color;
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.mainScrollView = [[UIScrollView alloc]init];
    self.mainScrollView.backgroundColor = BG_Nav;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView setShowsVerticalScrollIndicator:NO];
    
    NSInteger topH = 20;
    if(KIsiPhoneX){
        topH = 13;
    }else{
        topH = 20;
    }
    
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(-topH);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    UIView *contentView = [[UIView alloc]init];
    [contentView setBackgroundColor:Them_Color];
    [self.mainScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.width.equalTo(self.mainScrollView);
    }];
    
    UIView *headBgView = [[UIView alloc] init];
    headBgView.backgroundColor = BG_Nav;
    [contentView addSubview:headBgView];
    [headBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(220);
    }];
    
    GHandleView *handleView = [[GHandleView alloc] initMenu:self.handleMenus handleBlock:^(NSInteger index) {
        switch (index) {
            case 0:{
                GTransferAccountsVc *transferVc = [[GTransferAccountsVc alloc] init];
                [self.navigationController pushViewController:transferVc animated:YES];
            }
                break;
            case 1:{
                GDrawMoneyVc *drawVc = [[GDrawMoneyVc alloc] init];
                [self.navigationController pushViewController:drawVc animated:YES];
            }
                break;
            case 2:{
                GPayVc *payVc = [[GPayVc alloc] init];
                [self.navigationController pushViewController:payVc animated:YES];
            }
                break;
        }
    } WithLine:NO];
    [contentView addSubview:handleView];
    [handleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headBgView.mas_bottom);
        make.leading.equalTo(contentView).offset(20);
        make.trailing.equalTo(contentView).offset(-20);
        make.height.mas_equalTo(100);
    }];
    handleView.layer.cornerRadius = 8;
    handleView.layer.masksToBounds = YES;
    
    UIView *userView = [[UIView alloc] init];
    userView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:userView];
    [userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(120);
        make.leading.equalTo(contentView).offset(20);
        make.trailing.equalTo(contentView).offset(-20);
        make.height.mas_equalTo(120);
    }];
    userView.layer.cornerRadius = 8;
    userView.layer.masksToBounds = YES;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    [lineLabel setBackgroundColor:[UIColor colorWithRed:214.0/255 green:214.0/255 blue:214.0/255 alpha:1]];
    [userView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userView);
        make.top.equalTo(userView).offset(100);
        make.left.equalTo(userView.mas_left).offset(20);
        make.right.equalTo(userView.mas_right).offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lineSortLabel = [[UILabel alloc] init];
    [lineSortLabel setBackgroundColor:[UIColor colorWithRed:214.0/255 green:214.0/255 blue:214.0/255 alpha:1]];
    [userView addSubview:lineSortLabel];
    [lineSortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userView);
        make.top.equalTo(userView).offset(45);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(45);
    }];
    
    self.balanceLabel = [[UILabel alloc] init];
    self.balanceLabel.textColor = [UIColor blackColor];
    self.balanceLabel.font = [UIFont boldSystemFontOfSize:15.f];
    self.balanceLabel.text = [GTool stringMoneyFamat:[[SZUser shareUser] readBalance]];
    [userView addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userView).offset(35);
        make.left.equalTo(userView.mas_left).offset(20);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *balanceTitleLabel = [[UILabel alloc] init];
    balanceTitleLabel.textColor = [UIColor colorWithRed:184.0/255 green:183.0/255 blue:184.0/255 alpha:1];
    balanceTitleLabel.font = [UIFont systemFontOfSize:15.f];
    balanceTitleLabel.text = @"账户余额(元)";
    [userView addSubview:balanceTitleLabel];
    [balanceTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.balanceLabel.mas_bottom);
        make.left.equalTo(userView.mas_left).offset(20);
        make.height.mas_equalTo(25);
    }];
    
    UIImageView *rigthImv = [[UIImageView alloc] init];
    rigthImv.image = [UIImage imageNamed:@"cell_arrow_left"];
    [userView addSubview:rigthImv];
    [rigthImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userView).offset(65);
        make.trailing.equalTo(userView).offset(-20);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *assetButton = [[UIButton alloc] init];
    [assetButton setTitle:@"        总资产(元)" forState:UIControlStateNormal];
    assetButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    [assetButton setTitleColor:[UIColor colorWithRed:184.0/255 green:183.0/255 blue:184.0/255 alpha:1] forState:UIControlStateNormal];
    [assetButton.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [userView addSubview:assetButton];
    [assetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userView).offset(50);
        make.trailing.equalTo(userView);
        make.width.mas_equalTo(kScreenWidth / 2);
        make.height.mas_equalTo(50);
    }];
    [assetButton addTarget:self action:@selector(assetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    UILabel *tempLabel = [[UILabel alloc] init];
//    tempLabel.textColor = BG_Nav;
//    tempLabel.text = @"        --";
//    [userView addSubview:tempLabel];
//    [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(assetButton.mas_top).offset(10);
//        make.left.equalTo(assetButton.mas_left);
//        make.height.mas_equalTo(20);
//    }];
    
    UIImageView *logoImv = [[UIImageView alloc] init];
    logoImv.image = [UIImage imageNamed:@"logoicon"];
    [contentView addSubview:logoImv];
    [logoImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(85);
        make.centerX.equalTo(contentView);
        make.width.height.mas_equalTo(70);
    }];
    
    self.usernameLabel = [[UILabel alloc] init];
    self.usernameLabel.textColor = [UIColor whiteColor];
    self.usernameLabel.textAlignment = NSTextAlignmentCenter;
    self.usernameLabel.font = [UIFont systemFontOfSize:15.f];
    [contentView addSubview:self.usernameLabel];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(60);
        make.centerX.equalTo(contentView);
        make.height.mas_equalTo(25);
    }];
    
    GCheckView *checkView = [[GCheckView alloc] initMenu:self.checkMenus checkBlock:^(NSInteger index) {
        switch (index) {
            case 0:{
                GJournalAccountCapitalVc *jacVc = [[GJournalAccountCapitalVc alloc] init];
                [self.navigationController pushViewController:jacVc animated:YES];
            }
                break;
            case 1:{
                GBetRecordVc *betVc = [[GBetRecordVc alloc] init];
                [self.navigationController pushViewController:betVc animated:YES];
            }
                break;
            case 2:{
                GRechargeRecordVc *rechargeVc = [[GRechargeRecordVc alloc] init];
                [self.navigationController pushViewController:rechargeVc animated:YES];
            }
                break;
            case 3:{
                GTransferRecordVc *transferVc = [[GTransferRecordVc alloc] init];
                [self.navigationController pushViewController:transferVc animated:YES];
            }
                break;
            case 4:{
                GDrawRecordVc *drawVc = [[GDrawRecordVc alloc] init];
                [self.navigationController pushViewController:drawVc animated:YES];
            }
                break;
            case 5:{
                GAccountInfoVc *infoVc = [[GAccountInfoVc alloc] init];
                [self.navigationController pushViewController:infoVc animated:YES];
            }
                break;
            case 6:{
                GSafeSettingVc *safeSetVc = [[GSafeSettingVc alloc] init];
                [self.navigationController pushViewController:safeSetVc animated:YES];
            }
                break;
            case 7:{
                GNewActivityVc *newActVc = [[GNewActivityVc alloc] init];
                [self.navigationController pushViewController:newActVc animated:YES];
            }
                break;
            case 8:{
                GHelpVc *helpVc = [[GHelpVc alloc] init];
                helpVc.navTitle = @"帮助中心";
                [self.navigationController pushViewController:helpVc animated:YES];
            }
                break;
            case 9:{
                [self exitLogin];
            }
                break;
        }
    } WithLine:NO];
    [contentView addSubview:checkView];
    [checkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(handleView.mas_bottom).offset(40);
        make.leading.equalTo(contentView).offset(20);
        make.trailing.equalTo(contentView).offset(-20);
        make.height.mas_equalTo(400);
    }];
    checkView.layer.cornerRadius = 8;
    checkView.layer.masksToBounds = YES;
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(checkView).offset(20);
    }];
}

- (void)assetButtonClick:(UIButton *)button{
    GCapitalFundVc *cfVc = [[GCapitalFundVc alloc] init];
    [self.navigationController pushViewController:cfVc animated:YES];
}

- (void)exitLogin{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"退出账户，是否继续？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"SZHaveLogin"]) {
            
        }else{
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [SVProgressHUD showWithStatus:@"正在退出..."];
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
                if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                    
                    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
                    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kLogout RequestWay:kPOST withParamters:dic2 withToken:nil success:^(BOOL isSuccess, id responseObject) {
                        [[SZUser shareUser] deleteUser];
                        [[SZUser shareUser] saveExit];
                        
                        if (@available(iOS 10.0, *)) {
                            AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                            UIViewController *controller = app.window.rootViewController;
                            GTabBarVc *rvc = (GTabBarVc *)controller;
                            [rvc setSelectedIndex:0];
                            [rvc.gTabBar.plusBtn setTitle:@"注册" forState:UIControlStateNormal];
                            
                            UITabBarItem *barItem = self.tabBarItem;
                            barItem.title = TABBAR_LOGIN;
                        } else {
                            // Fallback on earlier versions
                        }
                        [SVProgressHUD dismiss];
                    } failure:^(NSError *error) {
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showErrorWithStatus:kNetError];
                    }];
                }else{
                    [[SZUser shareUser] deleteUser];
                    [[SZUser shareUser] saveExit];
                    
                    if (@available(iOS 10.0, *)) {
                        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        UIViewController *controller = app.window.rootViewController;
                        GTabBarVc *rvc = (GTabBarVc *)controller;
                        [rvc setSelectedIndex:0];
                        [rvc.gTabBar.plusBtn setTitle:@"注册" forState:UIControlStateNormal];
                        
                        UITabBarItem *barItem = self.tabBarItem;
                        barItem.title = TABBAR_LOGIN;
                    } else {
                        // Fallback on earlier versions
                    }
                    [SVProgressHUD dismiss];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
