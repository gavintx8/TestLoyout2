//
//  GLoginVC.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GLoginVC.h"
#import "GRegisterVc.h"
#import "GTabBarVc.h"

@interface GLoginVC () <UITextFieldDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) UITextField *userID;
@property (nonatomic, strong) UITextField *idPassword;
@property (nonatomic, strong) UIView *contentView ;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *backView;
@end

@implementation GLoginVC

- (void)onCreate {
    
    self.navigationItem.title = @"账号登录";
    self.view.backgroundColor = Them_Color;
    
    [self createUI];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGETABBARITEMTOZERO" object:nil];
    if(self.geectl != nil){
        [self.geectl.navigationController popViewControllerAnimated:YES];
    }
}

- (void)createUI {
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    self.backView.backgroundColor = [UIColor grayColor];
    self.backView = [[UIView alloc] init];
    [self.scrollView addSubview:self.backView];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"login_back"] forState:UIControlStateNormal];
    button.sz_size = CGSizeMake(70, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(20);
        make.left.equalTo(self.backView).offset(20);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];
    
    UIImageView *logoImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"login_logo_01"]];
    [self.backView addSubview:logoImv];
    [logoImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(NAVIGATION_HEIGHT + 80);
        make.centerX.equalTo(self.backView);
//        make.width.mas_equalTo(166);
//        make.height.mas_equalTo(52);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(44);
    }];
    
    self.contentView = [[UIView alloc] init];
    [self.backView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImv.mas_bottom).offset(30);
        make.left.equalTo(self.backView.mas_left).offset(20);
        make.right.equalTo(self.backView.mas_right).offset(-20);
        make.height.mas_equalTo(180);
    }];
    
    UIView *personView = [[UIView alloc] init];
    personView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:personView];
    [personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *personImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"login_name"]];
    [personView addSubview:personImv];
    [personImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personView).offset(10);
        make.centerY.equalTo(personView);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(15);
    }];
    
    self.userID = [GUIHelper getTextField:nil andFont:TXT_SIZE_13 andPlaceholder:@"请输入用户名"];
    self.userID.textColor = [UIColor blackColor];
    [self.userID setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [personView addSubview:self.userID];
    [self.userID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personImv.mas_right).offset(10);
        make.centerY.equalTo(personImv);
        make.right.equalTo(personView);
        make.height.mas_equalTo(40);
    }];
    self.userID.delegate = self;
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    [personView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(personView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *passwordView = [[UIView alloc] init];
    passwordView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personView.mas_bottom).offset(1);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *passworlImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"login_pass"]];
    [passwordView addSubview:passworlImv];
    [passworlImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passwordView).offset(10);
        make.centerY.equalTo(passwordView);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(15);
    }];
    
    self.idPassword = [GUIHelper getTextField:nil andFont:TXT_SIZE_13 andPlaceholder:@"请输入密码"];
    self.idPassword.textColor = [UIColor blackColor];
    [self.idPassword setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordView addSubview:self.idPassword];
    [self.idPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passworlImv.mas_right).offset(10);
        make.centerY.equalTo(passworlImv);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    self.idPassword.delegate = self;
    self.idPassword.secureTextEntry = YES;
    
    UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [passwordView addSubview:eyeBtn];
    [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passworlImv);
        make.right.equalTo(self.contentView).offset(-6);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(18);
    }];
    [eyeBtn setImage:[UIImage imageNamed:@"login_eye_01"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"login_eye_02"] forState:UIControlStateSelected];
    [eyeBtn addTarget:self action:@selector(eyeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel2 = [[UILabel alloc] init];
    lineLabel2.backgroundColor = [UIColor lightGrayColor];
    [passwordView addSubview:lineLabel2];
    [lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(passwordView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *loginBtn = [GUIHelper getButton:@"登录" titleColor:[UIColor whiteColor] font:TXT_SIZE_16];
    [loginBtn setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.masksToBounds = YES;
    [self.backView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordView.mas_bottom).offset(20);
        make.left.equalTo(self.backView).offset(20);
        make.right.equalTo(self.backView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *forgotPWBtn = [GUIHelper getButton:@"忘记密码？" titleColor:[UIColor colorWithHexStr:@"#A2A2A2"] font:TXT_SIZE_13];
//    [forgotPWBtn setBackgroundImage:[UIImage imageWithColor:Them_Color] forState:UIControlStateNormal];
//    [self.backView addSubview:forgotPWBtn];
//    [forgotPWBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(loginBtn.mas_right);
//        make.top.equalTo(loginBtn.mas_bottom).offset(20);
//        make.width.mas_equalTo(80);
//        make.height.mas_equalTo(35);
//    }];
//    forgotPWBtn.layer.cornerRadius = 5;
//    forgotPWBtn.layer.masksToBounds = YES;
//    [forgotPWBtn addTarget:self action:@selector(forgotPWBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *registerBtn = [GUIHelper getButton:@"立即注册" titleColor:[UIColor colorWithHexStr:@"#A2A2A2"] font:TXT_SIZE_13];
    [registerBtn setBackgroundImage:[UIImage imageWithColor:Them_Color] forState:UIControlStateNormal];
    [self.backView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(loginBtn.mas_right);
        make.top.equalTo(loginBtn.mas_bottom).offset(20);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(35);
    }];
    registerBtn.layer.cornerRadius = 5;
    registerBtn.layer.masksToBounds = YES;
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *bottomImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@""]];
    [self.backView addSubview:bottomImv];
    [bottomImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView.mas_bottom).offset(-60);
        make.centerX.equalTo(self.backView);
        make.width.mas_equalTo(203);
        make.height.mas_equalTo(100);
    }];
    
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
}

- (void)onWillShow {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)onWillDisappear{
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (BOOL)checkUserInfo {
    
    if ([GDataCheck isEmptyStr:self.userID.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入用户名"];
        return NO;
    }
    if ([GDataCheck isEmptyStr:self.idPassword.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return NO;
    }
    return YES;
}

- (void)loginBtnClick:(UIButton *)btn {
    btn.enabled = NO;
    if ([self checkUserInfo]) {
        NSString *tName = [[[SZUser shareUser] readPlatCodeLink] stringByAppendingString:self.userID.text];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"tname"] = tName;
        dic[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
        dic[@"tpwd"] = self.idPassword.text;
        dic[@"savelogin"] = @"1";
        dic[@"isImgCode"] = @"0";
        dic[@"isMobile"] = @"3";
        [SVProgressHUD showWithStatus:@"正在登录..."];
        [SVProgressHUD setMinimumDismissTimeInterval:1.0];
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
            
            SZUser *user = [SZUser shareUser];
            if ([responseObject[@"status"] isEqualToString:@"ok"]) {
                user.userKey = responseObject[@"userKey"];
                user.userName = responseObject[@"userName"];
                if (responseObject[@"balance"] == nil) {
                    user.balance = @"0.00";
                } else {
                    user.balance = responseObject[@"balance"];
                }
                user.integral = responseObject[@"integral"];
                user.password = self.idPassword.text;
                [SVProgressHUD dismiss];
                [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                [[SZUser shareUser] saveLogin];
                [[SZUser shareUser] saveUser];
                [[SZUser shareUser] saveBalance];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (@available(iOS 10.0, *)) {
                        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                        UIViewController *controller = app.window.rootViewController;
                        GTabBarVc *rvc = (GTabBarVc *)controller;
                        
                        UITabBarItem *barItem = rvc.vipVc.tabBarItem;
                        barItem.title = TABBAR_VIPCENTER;
                    } else {}
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTabBarName" object:nil];
                    [self back];
                });
            } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            if (error.code == -1009) {
                [SVProgressHUD showErrorWithStatus:@"无网络!"];
            }else {
                [SVProgressHUD showErrorWithStatus:@"访问失败!"];
            }
        }];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.enabled = YES;
    });
}

- (void)forgotPWBtnClick:(UIButton *)btn {
    [self back];
    if (@available(iOS 10.0, *)) {
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *controller = app.window.rootViewController;
        GTabBarVc *rvc = (GTabBarVc *)controller;
        rvc.selectedViewController = [rvc.viewControllers objectAtIndex:2];
    } else {}
}

- (void)registerBtnClick:(UIButton *)btn {
    GRegisterVc *gRegisterVc = [[GRegisterVc alloc] init];
    UINavigationController *registerVC = [[UINavigationController alloc] initWithRootViewController:gRegisterVc];
    gRegisterVc.ctl = self;
    [self presentViewController:registerVC animated:YES completion:nil];
}

- (void)eyeBtnClick:(UIButton *)btn {
    btn.selected = !btn.selected;
    NSString *passwordStr = self.idPassword.text;
    self.idPassword.text = nil;
    self.idPassword.text = passwordStr;
    self.idPassword.secureTextEntry = !self.idPassword.secureTextEntry;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.userID) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.userID.text.length >= 11) {
            self.userID.text = [textField.text substringToIndex:11];
            return NO;
        }
    }
    if (textField == self.idPassword) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.idPassword.text.length >= 12) {
            self.idPassword.text = [textField.text substringToIndex:12];
            return NO;
        }
    }
    return YES;
}
#pragma mark -—————————— UITextfieldDelegate ——————————
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.40f];//动画持续时间
    self.view.frame = CGRectMake(0.0f, -80, SCREEN_WIDTH, SCREEN_HEIGHT);
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.4 animations:^{
        self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.view endEditing:YES];
    return YES;
}

#pragma mark -—————————— UIScrollViewDelegate ——————————
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
