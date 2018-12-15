//
//  GRegisterVc.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GRegisterVc.h"
#import "GOpenAccountVc.h"
#import "GTabBarVc.h"
#import "PooCodeView.h"

@interface GRegisterVc () <UITableViewDelegate, UITextViewDelegate, UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITextField *referralCode;
@property (nonatomic, strong) UITextField *userID;
@property (nonatomic, strong) UITextField *idPassword;
@property (nonatomic, strong) UITextField *phoneNumberTextField;
@property (nonatomic, strong) UITextField *validateCodeTextField;
@property (nonatomic, strong) UIButton *selectProtocolBtn;
@property (nonatomic, strong) PooCodeView *pooCodeView;
@end

@implementation GRegisterVc

- (void)onCreate {
    // 注册
    [self setupNav];
    [self createUI];
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
    
    UIView *referralCodeView = [[UIView alloc] init];
    referralCodeView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:referralCodeView];
    [referralCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(30);
        make.left.equalTo(self.backView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    
    //username
    UIImageView *referralCodeImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"login_tjm"]];
    [referralCodeView addSubview:referralCodeImv];
    [referralCodeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(referralCodeView);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
        make.left.equalTo(referralCodeView.mas_left).offset(20);
    }];
    
    self.referralCode = [GUIHelper getTextField:nil andFont:TXT_SIZE_14 andPlaceholder:@"推荐码(非必填)"];
    self.referralCode.textColor = [UIColor blackColor];
    [self.referralCode setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [referralCodeView addSubview:self.referralCode];
    [self.referralCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(referralCodeImv.mas_right).offset(10);
        make.centerY.equalTo(referralCodeImv);
        make.right.equalTo(self.backView);
        make.height.mas_equalTo(40);
    }];
    
    UIView *personView = [[UIView alloc] init];
    personView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:personView];
    [personView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(referralCodeView.mas_bottom).offset(1);
        make.left.equalTo(self.backView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    
    //username
    UIImageView *personImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"login_name"]];
    [personView addSubview:personImv];
    [personImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(personView);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
        make.left.equalTo(personView.mas_left).offset(20);
    }];
    
    self.userID = [GUIHelper getTextField:nil andFont:TXT_SIZE_14 andPlaceholder:@"用户名(5-11位数字或字母)"];
    self.userID.textColor = [UIColor blackColor];
    [self.userID setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [personView addSubview:self.userID];
    [self.userID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(personImv.mas_right).offset(10);
        make.centerY.equalTo(personImv);
        make.right.equalTo(self.backView);
        make.height.mas_equalTo(40);
    }];
    self.userID.delegate = self;
    
    UIView *passwordView = [[UIView alloc] init];
    passwordView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personView.mas_bottom).offset(1);
        make.left.equalTo(self.backView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    
    // password
    UIImageView *passworlImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"login_pass"]];
    [passwordView addSubview:passworlImv];
    [passworlImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(passwordView);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(20);
        make.left.equalTo(passwordView.mas_left).offset(20);
    }];
    
    self.idPassword = [GUIHelper getTextField:nil andFont:TXT_SIZE_14 andPlaceholder:@"密码(6-12位数字或字母)"];
    self.idPassword.textColor = [UIColor blackColor];
    [self.idPassword setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordView addSubview:self.idPassword];
    [self.idPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(passworlImv.mas_right).offset(10);
        make.centerY.equalTo(passworlImv);
        make.right.equalTo(self.backView);
        make.height.mas_equalTo(40);
    }];
    self.idPassword.delegate = self;
    self.idPassword.secureTextEntry = YES;
    
    UIView *phoneView = [[UIView alloc] init];
    phoneView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordView.mas_bottom).offset(1);
        make.left.equalTo(self.backView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *phoneNumberImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"reg_phone"]];
    [phoneView addSubview:phoneNumberImv];
    [phoneNumberImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneView);
        make.width.mas_equalTo(23);
        make.height.mas_equalTo(25);
        make.left.equalTo(phoneView.mas_left).offset(20);
    }];
    
    self.phoneNumberTextField = [GUIHelper getTextField:nil andFont:TXT_SIZE_14 andPlaceholder:@"手机号"];
    self.phoneNumberTextField.textColor = [UIColor blackColor];
    [self.phoneNumberTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneView addSubview:self.phoneNumberTextField];
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(phoneNumberImv.mas_right).offset(10);
        make.centerY.equalTo(phoneNumberImv);
        make.right.equalTo(self.backView);
        make.height.mas_equalTo(40);
    }];
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTextField.delegate = self;
    
    UIView *validateCodeView = [[UIView alloc] init];
    validateCodeView.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:validateCodeView];
    [validateCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneView.mas_bottom).offset(1);
        make.left.equalTo(self.backView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
    }];
    
    UIImageView *validateCodeImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"reg_yzm"]];
    [validateCodeView addSubview:validateCodeImv];
    [validateCodeImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(validateCodeView);
        make.width.mas_equalTo(23);
        make.height.mas_equalTo(25);
        make.left.equalTo(validateCodeView.mas_left).offset(20);
    }];
    
    self.validateCodeTextField = [GUIHelper getTextField:nil andFont:TXT_SIZE_14 andPlaceholder:@"验证码"];
    self.validateCodeTextField.textColor = [UIColor blackColor];
    [self.validateCodeTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.validateCodeTextField.tag = 1001;
    [validateCodeView addSubview:self.validateCodeTextField];
    [self.validateCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(validateCodeImv.mas_right).offset(10);
        make.centerY.equalTo(validateCodeImv);
        make.right.equalTo(self.backView);
        make.height.mas_equalTo(40);
    }];
    self.validateCodeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.validateCodeTextField.delegate = self;
    
    self.pooCodeView = [[PooCodeView alloc] init];
    NSArray *randomArr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    self.pooCodeView = [[PooCodeView alloc] initWithFrame:CGRectMake(0, 0, 80, 40) andChangeArray:randomArr];
    self.pooCodeView.textSize = 20;
    self.pooCodeView.textColor = [UIColor redColor];
    [validateCodeView addSubview:self.pooCodeView];
    [self.pooCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(validateCodeView).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self.validateCodeTextField);
    }];
    
    UIView *selectProtocolView = [[UIView alloc] init];
    selectProtocolView.layer.cornerRadius = 5;
    selectProtocolView.layer.masksToBounds = YES;
    selectProtocolView.backgroundColor = Them_Color;
    [self.backView addSubview:selectProtocolView];
    [selectProtocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(validateCodeView.mas_bottom).offset(15);
        make.left.equalTo(self.backView).offset(20);
        make.width.mas_equalTo(SCREEN_WIDTH - 40);
        make.height.mas_equalTo(50);
    }];
    
    self.selectProtocolBtn = [GUIHelper getButtonWithImage:[UIImage imageNamed:@"checkbox"] selectImage:[UIImage imageNamed:@"checkbox_h"]];
    [selectProtocolView addSubview:self.selectProtocolBtn];
    [self.selectProtocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(selectProtocolView);
        make.left.equalTo(selectProtocolView.mas_left).offset(20);
        make.width.height.mas_equalTo(14);
    }];
    [self.selectProtocolBtn addTarget:self action:@selector(selectProtocolBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.selectProtocolBtn.selected = YES;
    
    UILabel *protocolLabel = [GUIHelper getLabel:@"我已届满合法博彩年龄,且同意各项" andFont:TXT_SIZE_12 andTextColor:BG_Gray];
    [selectProtocolView addSubview:protocolLabel];
    [protocolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectProtocolBtn.mas_right).offset(10);
        make.centerY.equalTo(self.selectProtocolBtn);
    }];
    [protocolLabel sizeToFit];
    
    UIButton *protocolBtn = [GUIHelper getButton:@"\"开户协议\"" titleColor:BG_Nav font:TXT_SIZE_12];
    [protocolBtn setBackgroundImage:[UIImage imageWithColor:Them_Color] forState:UIControlStateNormal];
    [selectProtocolView addSubview:protocolBtn];
    [protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(protocolLabel.mas_right).offset(1);
        make.centerY.equalTo(protocolLabel);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    [protocolBtn addTarget:self action:@selector(protocolBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextStepBtn = [GUIHelper getButton:@"立即注册" titleColor:[UIColor whiteColor] font:TXT_SIZE_16];
    [nextStepBtn setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateNormal];
    nextStepBtn.layer.cornerRadius = 5.0;
    nextStepBtn.layer.masksToBounds = YES;
    [nextStepBtn addTarget:self action:@selector(nextStepBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:nextStepBtn];
    [nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectProtocolView.mas_bottom).offset(30);
        make.width.mas_equalTo(ScreenW - 40);
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(45);
    }];
    
    UIImageView *bottomImv = [GUIHelper getImageViewImage:[UIImage imageNamed:@"login_logo_01"]];
    [self.backView addSubview:bottomImv];
    [bottomImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backView.mas_bottom).offset(-90);
        make.centerX.equalTo(self.backView);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(44);
    }];
    
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT - KNavBarHeight);
    }];
}

- (void)onWillShow {
    
}

- (void)onWillDisappear {
    [SVProgressHUD dismiss];
}

- (void)setupNav {
    
    self.navigationController.navigationBar.barTintColor = BG_Nav;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.view.backgroundColor = Them_Color;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"top_Back_nor"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"top_Back_pre"] forState:UIControlStateHighlighted];
    button.sz_size = CGSizeMake(70, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // 隐藏tabbar
    self.hidesBottomBarWhenPushed = YES;
    self.navigationItem.title = @"快速注册";
}

#pragma mark ----------------  UITableViewDelegate and UITableViewDataSource  -----------------------
//勾选
- (void)selectProtocolBtn:(UIButton *)btn {
    
    btn.selected = !btn.selected;
}

- (void)protocolBtnClick:(UIButton *)btn {
    
    GOpenAccountVc *gOpenAccountVc = [[GOpenAccountVc alloc] init];
    gOpenAccountVc.navTitle = @"开户协议";
    gOpenAccountVc.htmlName = @"service_terms.html";
    gOpenAccountVc.regVc = self;
    [self.navigationController pushViewController:gOpenAccountVc animated:YES];
}

//下一步
- (void)nextStepBtn:(UIButton *)btn {
    btn.enabled = NO;
    if ([self chkUsrInfoN]) {
        [SVProgressHUD showWithStatus:@"正在注册..."];
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetToken RequestWay:kPOST withParamters:nil withToken:nil success:^(BOOL isSuccess, id responseObject) {
            
            if (![responseObject[@"msg"] isEqualToString:@"error"]) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                dic[@"mobileNo"] = self.phoneNumberTextField.text;
                dic[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
                dic[@"passWord"] = self.idPassword.text;
                dic[@"repassWord"] = self.idPassword.text;
                dic[@"reguuid"] = responseObject[@"msg"];
                dic[@"isMobile"] = @"3";
                dic[@"realName"] = @"会员";
                dic[@"userName"] = self.userID.text;
                dic[@"isImgCode"] = @"0";
                dic[@"referralCode"] = self.referralCode.text;
                
                [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kRegister RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
                    
                    SZUser *user = [SZUser shareUser];
                    if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                        user.userKey = responseObject[@"userKey"];
                        user.userName = responseObject[@"userName"];
                        user.password = self.idPassword.text;
                        if (responseObject[@"balance"] == nil) {
                            user.balance = @"0.00";
                        } else {
                            user.balance = responseObject[@"balance"];
                            [[SZUser shareUser] saveBalance2:[NSString stringWithFormat:@"%@",responseObject[@"balance"]]];
                        }
                        [SVProgressHUD dismiss];
                        [SVProgressHUD showSuccessWithStatus:@"注册成功,已登录"];
                        [[SZUser shareUser] saveLogin];
                        [[SZUser shareUser] saveUser];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self back];
                            [self.ctl dismissViewControllerAnimated:NO completion:nil];
                            if (@available(iOS 10.0, *)) {
                                AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                UIViewController *controller = app.window.rootViewController;
                                GTabBarVc *rvc = (GTabBarVc *)controller;
                                
                                UITabBarItem *barItem = rvc.vipVc.tabBarItem;
                                barItem.title = TABBAR_VIPCENTER;
                            } else {}
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTabBarName" object:nil];
                        });
                    }else if ([responseObject[@"msg"] isEqualToString:@"001"]) {
                        [SVProgressHUD showErrorWithStatus:@"用户名为空"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"002"]) {
                        [SVProgressHUD showErrorWithStatus:@"用户名格式不正确"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"003"]) {
                        [SVProgressHUD showErrorWithStatus:@"手机号为空"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"004"]) {
                        [SVProgressHUD showErrorWithStatus:@"手机号不正确"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"005"]) {
                        [SVProgressHUD showErrorWithStatus:@"密码为空"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"006"]) {
                        [SVProgressHUD showErrorWithStatus:@"确认密码为空"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"007"]) {
                        [SVProgressHUD showErrorWithStatus:@"两次密码不一致"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"008"]) {
                        [SVProgressHUD showErrorWithStatus:@"密码格式不正确"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"009"]) {
                        [SVProgressHUD showErrorWithStatus:@"账号已存在"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"010"]) {
                        [SVProgressHUD showErrorWithStatus:@"密钥为空"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"011"]) {
                        [SVProgressHUD showErrorWithStatus:@"图片验证码为空"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"012"]) {
                        [SVProgressHUD showErrorWithStatus:@"图片验证码错误"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"013"]) {
                        [SVProgressHUD showErrorWithStatus:@"取款密码为空"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"014"]) {
                        [SVProgressHUD showErrorWithStatus:@"确认取款密码为空"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"015"]) {
                        [SVProgressHUD showErrorWithStatus:@"两次取款密码不一致"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"016"]) {
                        [SVProgressHUD showErrorWithStatus:@"取款密码格式不正确"];
                    }else if ([responseObject[@"msg"] isEqualToString:@"017"]) {
                        [SVProgressHUD showErrorWithStatus:@"取款密码不能与登录密码相同"];
                    }else{
                        if(responseObject[@"msg"]){
                            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
                        }else{
                            [SVProgressHUD showErrorWithStatus:@"网络异常"];
                        }
                    }
                } failure:^(NSError *error) {
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"注册失败"];
                }];
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

- (BOOL)chkUsrInfoN {
    NSString *account = self.userID.text;
    NSString *password = self.idPassword.text;
    
    //检测账号------
    [SVProgressHUD dismissWithDelay:1.0];
    if (!self.selectProtocolBtn.selected) {
        [SVProgressHUD showErrorWithStatus:@"是否同意用户协议"];
        self.selectProtocolBtn.selected = YES;
        return NO;
    }
    
    if (![GDataCheck validateUserName:account]) {
        [SVProgressHUD showErrorWithStatus:@"用户名为5-11位字母,数字组成"];
        return NO;
    }
    
    if ([password linkus_isValidPassword] == NO) {
        [SVProgressHUD showErrorWithStatus:@"密码为6-12位英文或数字,且符合a~z字元或0~9"];
        return NO;
    }
    
    if (![GDataCheck isValidateMobile:self.phoneNumberTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"手机号格式不对"];
        return NO;
    }
    
    int result1 = [self.pooCodeView.changeString compare:self.validateCodeTextField.text options:NSCaseInsensitiveSearch];
    if ((self.pooCodeView.changeString.length == self.validateCodeTextField.text.length ) && (result1 == 0)) {
        NSLog(@"匹配正确");
    }else{
        [SVProgressHUD showErrorWithStatus:@"验证码错误"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.pooCodeView changeCode];
        });
        return NO;
    }
    
    return YES;
}

- (void)back {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CHANGETABBARITEMTOZERO" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    if (textField == self.phoneNumberTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.phoneNumberTextField.text.length >= 13) {
            self.phoneNumberTextField.text = [textField.text substringToIndex:13];
            return NO;
        }
    }
    if (textField == self.validateCodeTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.validateCodeTextField.text.length >= 4) {
            self.validateCodeTextField.text = [textField.text substringToIndex:4];
            return NO;
        }
    }
    return YES;
}

#pragma mark ----------------------- UIScrollViewDelegate -----------------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
}

@end
