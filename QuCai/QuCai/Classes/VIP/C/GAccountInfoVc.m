//
//  GAccountInfoVc.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GAccountInfoVc.h"
#import "AppDelegate.h"
#import "GTabBarVc.h"
#import "GBindingPhoneVc.h"

@interface GAccountInfoVc ()

@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) UILabel *registerTimeLabel;
@property (nonatomic, strong) UILabel *lastLoginTimeLabel;
@property (nonatomic, strong) UILabel *realNameLabel;

@end

@implementation GAccountInfoVc

- (void) onCreate {
    
    [self setupNav];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    
    [self loadData];
    
    [self buildView:self.view];
    
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"账户信息";
}

- (void) onWillShow {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)loadData {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"加载中"];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self getUserInfo];
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
                    
                    [self getUserInfo];
                } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                }
                [SVProgressHUD dismiss];
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

- (void)getUserInfo{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetUserInfo RequestWay:kPOST withParamters:dict withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        NSDictionary *dic = [[NSDictionary alloc] init];
        dic = responseObject;
        if (dic != nil) {
            NSString *username = [[SZUser shareUser].readUser.userName stringByReplacingOccurrencesOfString:[[SZUser shareUser] readPlatCodeLink] withString:@""];
            self.userNameLabel.text = [username stringByReplacingOccurrencesOfString:@"tas" withString:@""];
            [self.phoneButton setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"mobile"]] forState:UIControlStateNormal];
            NSDictionary *dictRegDate = [dic objectForKey:@"reg_date"];
            self.registerTimeLabel.text = [GTool UTCchangeDate:[NSString stringWithFormat:@"%@",[dictRegDate objectForKey:@"time"]]];
            NSDictionary *dictLoginDate = [dic objectForKey:@"login_time"];
            self.lastLoginTimeLabel.text = [GTool UTCchangeDate:[NSString stringWithFormat:@"%@",[dictLoginDate objectForKey:@"time"]]];
            if([[NSString stringWithFormat:@"%@",[dic objectForKey:@"realname"]] isEqualToString:@"会员"]){
                self.realNameLabel.text = @"";
            }else{
                self.realNameLabel.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"realname"]];
            }
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)buildView:(UIView *)view{
    UIView *bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(KNavBarHeight2);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(475);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor colorWithRed:183.0/255 green:183.0/255 blue:183.0/255 alpha:1];
    titleLabel.text = @"    个人基本信息";
    titleLabel.font = [UIFont systemFontOfSize:15.f];
    titleLabel.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(60);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(40);
    }];
    
    UIView *line0 = [[UIView alloc] init];
    line0.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *avtorLabel = [[UILabel alloc] init];
    [avtorLabel setText:@"头像"];
    [avtorLabel setTextColor:[UIColor blackColor]];
    [avtorLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:avtorLabel];
    [avtorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.equalTo(bgView).offset(20);
        make.height.mas_equalTo(60);
    }];
    
    UIImageView *avtorImv = [[UIImageView alloc] init];
    [avtorImv setImage:[UIImage imageNamed:@"logoicon"]];
    [bgView addSubview:avtorImv];
    [avtorImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(avtorLabel);
        make.trailing.equalTo(bgView).offset(-20);
        make.height.mas_equalTo(55);
        make.width.mas_equalTo(55);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(avtorLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *userNameTitleLabel = [[UILabel alloc] init];
    [userNameTitleLabel setText:@"用户名"];
    [userNameTitleLabel setTextColor:[UIColor blackColor]];
    [userNameTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:userNameTitleLabel];
    [userNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(bgView).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    self.userNameLabel = [[UILabel alloc] init];
    [self.userNameLabel setTextColor:[UIColor blackColor]];
    [self.userNameLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.trailing.equalTo(bgView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *realNameTitleLabel = [[UILabel alloc] init];
    [realNameTitleLabel setText:@"真实姓名"];
    [realNameTitleLabel setTextColor:[UIColor blackColor]];
    [realNameTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:realNameTitleLabel];
    [realNameTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(bgView).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    self.realNameLabel = [[UILabel alloc] init];
    [self.realNameLabel setTextColor:[UIColor blackColor]];
    [self.realNameLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:self.realNameLabel];
    [self.realNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.trailing.equalTo(bgView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(realNameTitleLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *phoneTitleLabel = [[UILabel alloc] init];
    [phoneTitleLabel setText:@"手机号"];
    [phoneTitleLabel setTextColor:[UIColor blackColor]];
    [phoneTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(bgView).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    UIImageView *rightImv = [[UIImageView alloc] init];
    [rightImv setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [bgView addSubview:rightImv];
    [rightImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneTitleLabel);
        make.trailing.equalTo(bgView).offset(-15);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(10);
    }];
    
    self.phoneButton = [[UIButton alloc] init];
    [self.phoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.phoneButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [bgView addSubview:self.phoneButton];
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(200);
    }];
    [self.phoneButton addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTitleLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.textColor = [UIColor colorWithRed:183.0/255 green:183.0/255 blue:183.0/255 alpha:1];
    titleLabel2.text = @"    账号信息";
    titleLabel2.font = [UIFont systemFontOfSize:15.f];
    titleLabel2.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [bgView addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(40);
    }];
    
    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleLabel2.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *registerTimeTitleLabel = [[UILabel alloc] init];
    [registerTimeTitleLabel setText:@"注册时间"];
    [registerTimeTitleLabel setTextColor:[UIColor blackColor]];
    [registerTimeTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:registerTimeTitleLabel];
    [registerTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line5.mas_bottom);
        make.left.equalTo(bgView).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    self.registerTimeLabel = [[UILabel alloc] init];
    [self.registerTimeLabel setTextColor:[UIColor blackColor]];
    [self.registerTimeLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:self.registerTimeLabel];
    [self.registerTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line5.mas_bottom);
        make.trailing.equalTo(bgView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line6 = [[UIView alloc] init];
    line6.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line6];
    [line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(registerTimeTitleLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lastLoginTimeTitleLabel = [[UILabel alloc] init];
    [lastLoginTimeTitleLabel setText:@"最后登录时间"];
    [lastLoginTimeTitleLabel setTextColor:[UIColor blackColor]];
    [lastLoginTimeTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:lastLoginTimeTitleLabel];
    [lastLoginTimeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line6.mas_bottom);
        make.left.equalTo(bgView).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    self.lastLoginTimeLabel = [[UILabel alloc] init];
    [self.lastLoginTimeLabel setTextColor:[UIColor blackColor]];
    [self.lastLoginTimeLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:self.lastLoginTimeLabel];
    [self.lastLoginTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line6.mas_bottom);
        make.trailing.equalTo(bgView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line7 = [[UIView alloc] init];
    line7.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line7];
    [line7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastLoginTimeTitleLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *vertionTitleLabel = [[UILabel alloc] init];
    [vertionTitleLabel setText:@"版本信息"];
    [vertionTitleLabel setTextColor:[UIColor blackColor]];
    [vertionTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:vertionTitleLabel];
    [vertionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line7.mas_bottom);
        make.left.equalTo(bgView).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *vertionLabel = [[UILabel alloc] init];
    [vertionLabel setTextColor:[UIColor blackColor]];
    [vertionLabel setFont:[UIFont systemFontOfSize:14.f]];
    [vertionLabel setText:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [bgView addSubview:vertionLabel];
    [vertionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line7.mas_bottom);
        make.trailing.equalTo(bgView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line8 = [[UIView alloc] init];
    line8.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line8];
    [line8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(vertionTitleLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *exitButton = [[UIButton alloc] init];
    [exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [exitButton setBackgroundColor:BG_Nav];
    exitButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [exitButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [exitButton setTag:1122];
    [view addSubview:exitButton];
    [exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line8).offset(30);
        make.centerX.equalTo(bgView);
        make.width.equalTo(@150);
        make.height.mas_equalTo(42);
    }];
    [exitButton.layer setCornerRadius:3];
    exitButton.layer.masksToBounds = YES;
    [exitButton addTarget:self action:@selector(exitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}


- (UILabel *)createSectionLabelTitle:(NSString *)title{
    
    UILabel *lbl = [[UILabel alloc] init];
    lbl.adjustsFontSizeToFitWidth =YES;
    [lbl setText:title];
    [lbl setFont:[UIFont boldSystemFontOfSize:15.f]];
    [lbl setTextAlignment:NSTextAlignmentLeft];
    [lbl setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    [lbl setTextColor:[UIColor colorWithRed:114.0/255 green:114.0/255 blue:114.0/255 alpha:1]];
    return lbl;
}

- (void)phoneButtonClick:(UIButton *)button{
    GBindingPhoneVc *phoneVc = [[GBindingPhoneVc alloc] init];
    phoneVc.phone = self.phoneButton.titleLabel.text;
    [self.navigationController pushViewController:phoneVc animated:YES];
}

- (void)exitButtonClick:(UIButton *)button{
    
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
                            
                            UITabBarItem *barItem = self.parentViewController.tabBarItem;
                            barItem.title = TABBAR_LOGIN;
                        } else {}
                        [SVProgressHUD dismiss];
                        [self.navigationController popViewControllerAnimated:NO];
                    } failure:^(NSError *error) {
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
                    } else {}
                    [SVProgressHUD dismiss];
                    [self.navigationController popViewControllerAnimated:NO];
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
