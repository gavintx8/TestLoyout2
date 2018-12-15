//
//  GSettingLoginPwdVc.m
//  QuCai
//
//  Created by mac on 2017/7/16.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GSettingLoginPwdVc.h"

@interface GSettingLoginPwdVc ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *oldPwdTextField;
@property (nonatomic, strong) UITextField *nPwdTextField;
@property (nonatomic, strong) UITextField *nPwdConfirmTextField;

@end

@implementation GSettingLoginPwdVc

- (void) onCreate {
    
    [self setupNav];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    
    [self buildView:self.view];
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"修改登录密码";
}

- (void) onWillShow {

}

- (void)buildView:(UIView *)view{
    
    UIView *bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(KNavBarHeight2);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(206);
    }];
    
    UIView *line0 = [[UIView alloc] init];
    line0.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(60);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *drawLabel = [[UILabel alloc] init];
    [drawLabel setText:@"原密码"];
    [drawLabel setTextColor:[UIColor blackColor]];
    drawLabel.textAlignment = NSTextAlignmentRight;
    [drawLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:drawLabel];
    [drawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line0.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_offset(80);
    }];
    
    self.oldPwdTextField = [[UITextField alloc] init];
    self.oldPwdTextField.delegate = self;
    [self.oldPwdTextField setFont:[UIFont systemFontOfSize:14.f]];
    self.oldPwdTextField.secureTextEntry = YES;
    [self.oldPwdTextField setPlaceholder:@""];
    [self.oldPwdTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bgView addSubview:self.oldPwdTextField];
    [self.oldPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line0.mas_bottom);
        make.left.equalTo(drawLabel.mas_right).offset(10);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(drawLabel.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *drawConfimLabel = [[UILabel alloc] init];
    [drawConfimLabel setText:@"新密码"];
    drawConfimLabel.textAlignment = NSTextAlignmentRight;
    [drawConfimLabel setTextColor:[UIColor blackColor]];
    [drawConfimLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:drawConfimLabel];
    [drawConfimLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_offset(80);
    }];
    
    self.nPwdTextField = [[UITextField alloc] init];
    self.nPwdTextField.delegate = self;
    [self.nPwdTextField setFont:[UIFont systemFontOfSize:14.f]];
    self.nPwdTextField.secureTextEntry = YES;
    [self.nPwdTextField setPlaceholder:@"密码必须6～12位英文或数字"];
    [self.nPwdTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bgView addSubview:self.nPwdTextField];
    [self.nPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(drawConfimLabel.mas_right).offset(10);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(drawConfimLabel.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *loginConfimLabel = [[UILabel alloc] init];
    [loginConfimLabel setText:@"确认密码"];
    loginConfimLabel.textAlignment = NSTextAlignmentRight;
    [loginConfimLabel setTextColor:[UIColor blackColor]];
    [loginConfimLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:loginConfimLabel];
    [loginConfimLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_offset(80);
    }];
    
    self.nPwdConfirmTextField = [[UITextField alloc] init];
    self.nPwdConfirmTextField.delegate = self;
    [self.nPwdConfirmTextField setFont:[UIFont systemFontOfSize:14.f]];
    self.nPwdConfirmTextField.secureTextEntry = YES;
    [self.nPwdConfirmTextField setPlaceholder:@"请再次填写新密码"];
    [self.nPwdConfirmTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bgView addSubview:self.nPwdConfirmTextField];
    [self.nPwdConfirmTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(loginConfimLabel.mas_right).offset(10);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginConfimLabel.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    NSString *label_text2 = @"密码须为6～12位英文或数字且符合a~z字元或0~9";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(0, 4)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:64.0/255 green:151.0/255 blue:224.0/255 alpha:1] range:NSMakeRange(4, 10)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(14, 12)];
    UILabel *label5 = [[UILabel alloc] init];
    [label5 setFont:[UIFont systemFontOfSize:12.f]];
    label5.attributedText = attributedString2;
    label5.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(20);
        make.centerX.equalTo(view);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [nextButton setTitle:@"立即设置" forState:UIControlStateNormal];
    [nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [nextButton setTag:1122];
    [view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label5).offset(30);
        make.centerX.equalTo(view);
        make.width.equalTo(@200);
        make.height.mas_equalTo(42);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextButtonClick:(UIButton *)sender{
    
    if([self.oldPwdTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入旧密码"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if(self.oldPwdTextField.text.length < 6){
        [SVProgressHUD showInfoWithStatus:@"旧密码太短，请重新输入"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.oldPwdTextField.text = @"";
        return;
    }
    if([self.nPwdTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入新密码"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if(self.nPwdTextField.text.length < 6){
        [SVProgressHUD showInfoWithStatus:@"新密码太短，请重新输入"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.nPwdTextField.text = @"";
        return;
    }
    if(![self.nPwdTextField.text isEqualToString:self.nPwdConfirmTextField.text]){
        [SVProgressHUD showInfoWithStatus:@"两次输入的新密码不匹配，请重新输入"];
        [SVProgressHUD dismissWithDelay:1];
        self.nPwdTextField.text = @"";
        self.nPwdConfirmTextField.text = @"";
        return;
    }
    if([self.nPwdTextField.text isEqualToString:self.oldPwdTextField.text]){
        [SVProgressHUD showInfoWithStatus:@"不能与旧密码相同，请重新输入"];
        [SVProgressHUD dismissWithDelay:1];
        self.nPwdTextField.text = @"";
        self.nPwdConfirmTextField.text = @"";
        return;
    }
    
    sender.enabled = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"提交中..."];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self modifyPassword];
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
                    
                    [self modifyPassword];
                } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
}

- (void)modifyPassword{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"password"] = self.oldPwdTextField.text;
    dic[@"npassword"] = self.nPwdTextField.text;
    dic[@"renpassword"] = self.nPwdConfirmTextField.text;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kChangePassword RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {

        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"恭喜您，修改成功！"];
            
            NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
            dicInfo[@"tname"] = [SZUser shareUser].readUser.userName;
            dicInfo[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
            dicInfo[@"tpwd"] = self.nPwdTextField.text;
            dicInfo[@"savelogin"] = @"1";
            dicInfo[@"isImgCode"] = @"0";
            
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
                    user.password = self.nPwdTextField.text;
                    [[SZUser shareUser] deleteUser];
                    [[SZUser shareUser] saveLogin];
                    [[SZUser shareUser] saveUser];
                    
                    self.oldPwdTextField.text = @"";
                    self.nPwdConfirmTextField.text = @"";
                    self.nPwdTextField.text = @"";
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
            
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"错误码：%@",responseObject[@"msg"]]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.oldPwdTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.oldPwdTextField.text.length >= 12) {
            self.oldPwdTextField.text = [textField.text substringToIndex:12];
            return NO;
        }
    }
    if (textField == self.nPwdTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.nPwdTextField.text.length >= 12) {
            self.nPwdTextField.text = [textField.text substringToIndex:12];
            return NO;
        }
    }
    if (textField == self.nPwdConfirmTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.nPwdConfirmTextField.text.length >= 12) {
            self.nPwdConfirmTextField.text = [textField.text substringToIndex:12];
            return NO;
        }
    }
    return YES;
}

@end
