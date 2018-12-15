//
//  GBindingPhoneVc.m
//  QuCai
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBindingPhoneVc.h"
#import "ContactServiceVc2.h"
#import "JKCountDownButton.h"

@interface GBindingPhoneVc ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UIView *modifyView;

@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UITextField *verfiyTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) JKCountDownButton *verifyButton;

@end

@implementation GBindingPhoneVc

- (void) onCreate {
    
    [self setupNav];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    
    [self buildInfoView:self.view];
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"绑定手机";
}

- (void) onWillShow {
    
}

- (void)buildInfoView:(UIView *)view{
    
    self.infoView = [[UIView alloc] init];
    [view addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(KNavBarHeight);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(255);
    }];
    
    UILabel *titleLabel = [self createSectionLabelTitle:@""];
    [titleLabel setBackgroundColor:[UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1]];
    [self.infoView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView);
        make.left.right.equalTo(self.infoView);
        make.height.mas_equalTo(10);
    }];

    UIView *line0 = [[UIView alloc] init];
    line0.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.infoView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleLabel.mas_bottom);
        make.left.right.equalTo(self.infoView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *phoneTitleLabel = [[UILabel alloc] init];
    [phoneTitleLabel setText:@"    绑定手机"];
    [phoneTitleLabel setTextColor:[UIColor blackColor]];
    [phoneTitleLabel setBackgroundColor:[UIColor whiteColor]];
    [phoneTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.infoView addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.right.equalTo(self.infoView);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    [phoneLabel setText:self.phone];
    [phoneLabel setTextColor:[UIColor blackColor]];
    [phoneLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.infoView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.trailing.equalTo(self.infoView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.infoView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTitleLabel.mas_bottom);
        make.left.right.equalTo(self.infoView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *modifyPhoneButton = [[UIButton alloc] init];
    [modifyPhoneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [modifyPhoneButton setBackgroundColor:BG_Nav];
    modifyPhoneButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [modifyPhoneButton setTitle:@"修改手机号" forState:UIControlStateNormal];
    [modifyPhoneButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [modifyPhoneButton setTag:1122];
    [self.infoView addSubview:modifyPhoneButton];
    [modifyPhoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1).offset(30);
        make.centerX.equalTo(self.infoView);
        make.width.equalTo(@150);
        make.height.mas_equalTo(42);
    }];
    [modifyPhoneButton.layer setCornerRadius:3];
    modifyPhoneButton.layer.masksToBounds = YES;
    [modifyPhoneButton addTarget:self action:@selector(modifyPhoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label4 = [[UILabel alloc] init];
    [label4 setFont:[UIFont systemFontOfSize:12.f]];
    [label4 setText:@"1.更换手机号后,下次登录可使用新手机号登录"];
    [label4 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    label4.textAlignment = NSTextAlignmentLeft;
    [self.infoView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(modifyPhoneButton.mas_bottom).offset(10);
        make.left.equalTo(modifyPhoneButton.mas_left).offset(-40);
        make.height.mas_equalTo(20);
    }];
    
    NSString *label_text2 = @"2.如您无法自助修改手机号,请联系在线客服";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:Title_Red range:NSMakeRange(17, 4)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(0, 17)];
    UILabel *label5 = [[UILabel alloc] init];
    [label5 setFont:[UIFont systemFontOfSize:12.f]];
    label5.attributedText = attributedString2;
    label5.textAlignment = NSTextAlignmentLeft;
    [self.infoView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4.mas_bottom).offset(7);
        make.left.equalTo(modifyPhoneButton.mas_left).offset(-40);
        make.height.mas_equalTo(20);
    }];
    [label5 yb_addAttributeTapActionWithStrings:@[@"在线客服"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
        [self.navigationController pushViewController:csVc animated:YES];
    }];
}

- (void)buildModifyView:(UIView *)view{
    self.modifyView = [[UIView alloc] init];
    [self.modifyView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:self.modifyView];
    [self.modifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(KNavBarHeight);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(210);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor colorWithRed:183.0/255 green:183.0/255 blue:183.0/255 alpha:1];
    titleLabel.text = @"    请输入您需要绑定的手机号";
    titleLabel.font = [UIFont systemFontOfSize:13.f];
    titleLabel.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [self.modifyView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.modifyView);
        make.left.right.equalTo(self.modifyView);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line0 = [[UIView alloc] init];
    line0.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.modifyView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleLabel.mas_bottom);
        make.left.right.equalTo(self.modifyView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *zoneTitleLabel = [[UILabel alloc] init];
    [zoneTitleLabel setText:@"国家/地区"];
    zoneTitleLabel.textAlignment = NSTextAlignmentRight;
    [zoneTitleLabel setTextColor:[UIColor blackColor]];
    [zoneTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.modifyView addSubview:zoneTitleLabel];
    [zoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.equalTo(self.modifyView);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(80);
    }];
    
    UILabel *zoneTitleLabel2 = [[UILabel alloc] init];
    [zoneTitleLabel2 setText:@"中国"];
    [zoneTitleLabel2 setTextColor:[UIColor blackColor]];
    [zoneTitleLabel2 setFont:[UIFont systemFontOfSize:14.f]];
    [self.modifyView addSubview:zoneTitleLabel2];
    [zoneTitleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.equalTo(zoneTitleLabel.mas_right).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.modifyView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(zoneTitleLabel.mas_bottom);
        make.left.right.equalTo(self.modifyView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *phoneTitleLabel = [[UILabel alloc] init];
    [phoneTitleLabel setText:@"+86"];
    phoneTitleLabel.textAlignment = NSTextAlignmentRight;
    [phoneTitleLabel setTextColor:[UIColor blackColor]];
    [phoneTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.modifyView addSubview:phoneTitleLabel];
    [phoneTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(self.modifyView);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(80);
    }];
    
    self.phoneTextField = [[UITextField alloc] init];
    self.phoneTextField.delegate = self;
    [self.phoneTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.phoneTextField setPlaceholder:@"请输入手机号"];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.phoneTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.modifyView addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(phoneTitleLabel.mas_right).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(180);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.modifyView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(phoneTitleLabel.mas_bottom);
        make.left.right.equalTo(self.modifyView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *verfiyTitleLabel = [[UILabel alloc] init];
    [verfiyTitleLabel setText:@"验证码"];
    verfiyTitleLabel.textAlignment = NSTextAlignmentRight;
    [verfiyTitleLabel setTextColor:[UIColor blackColor]];
    [verfiyTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.modifyView addSubview:verfiyTitleLabel];
    [verfiyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(self.modifyView);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(80);
    }];
    
    self.verfiyTextField = [[UITextField alloc] init];
    self.verfiyTextField.delegate = self;
    self.verfiyTextField.secureTextEntry = YES;
    [self.verfiyTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.verfiyTextField setPlaceholder:@"验证码"];
    [self.verfiyTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.modifyView addSubview:self.verfiyTextField];
    [self.verfiyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(verfiyTitleLabel.mas_right).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(180);
    }];
    
    self.verifyButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    [self.verifyButton setBackgroundColor:BG_Nav];
    [self.verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.verifyButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    self.verifyButton.layer.masksToBounds = YES;
    [GTool dc_chageControlCircularWith:self.verifyButton AndSetCornerRadius:5 SetBorderWidth:1 SetBorderColor:Title_Red canMasksToBounds:YES];
    [self.verifyButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.modifyView addSubview:self.verifyButton];
    [self.verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.verfiyTextField);
        make.trailing.equalTo(self.modifyView).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
    }];
    [self.verifyButton countDownButtonHandler:^(JKCountDownButton*sender, NSInteger tag) {
        
        if([self.phoneTextField.text isEqualToString:@""]){
            [SVProgressHUD showInfoWithStatus:@"请输入手机号码"];
            [SVProgressHUD dismissWithDelay:0.5];
            return;
        }
        if(![GTool valiMobile:self.phoneTextField.text]){
            [SVProgressHUD showInfoWithStatus:@"手机号码格式错误"];
            [SVProgressHUD dismissWithDelay:0.5];
            return;
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
        dic[@"mobileNo"] = self.phoneTextField.text;
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kSendChangeCode RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
            if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
                [SVProgressHUD showSuccessWithStatus:@"验证码发送成功！"];
                [sender startCountDownWithSecond:60];
                sender.enabled = NO;
                [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                    NSString *title = [NSString stringWithFormat:@"重新获取%zd秒",second];
                    return title;
                }];
            }else{
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"msg"]]];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
        
        [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            countDownButton.enabled = YES;
            return @"重新发送";
        }];
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.modifyView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(verfiyTitleLabel.mas_bottom);
        make.left.right.equalTo(self.modifyView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *pwdTitleLabel = [[UILabel alloc] init];
    [pwdTitleLabel setText:@"登录密码"];
    pwdTitleLabel.textAlignment = NSTextAlignmentRight;
    [pwdTitleLabel setTextColor:[UIColor blackColor]];
    [pwdTitleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.modifyView addSubview:pwdTitleLabel];
    [pwdTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(self.modifyView);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(80);
    }];
    
    self.pwdTextField = [[UITextField alloc] init];
    self.pwdTextField.delegate = self;
    self.pwdTextField.secureTextEntry = YES;
    [self.pwdTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.pwdTextField setPlaceholder:@"密码"];
    [self.pwdTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.modifyView addSubview:self.pwdTextField];
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(pwdTitleLabel.mas_right).offset(20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(180);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.modifyView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(pwdTitleLabel.mas_bottom);
        make.left.right.equalTo(self.modifyView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [nextButton setTag:1122];
    [view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4).offset(30);
        make.centerX.equalTo(view);
        make.width.equalTo(@150);
        make.height.mas_equalTo(42);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)modifyPhoneButtonClick:(UIButton *)button{
    self.infoView.hidden = YES;
    [self buildModifyView:self.view];
}

- (void)nextButtonClick:(UIButton *)button{
    if([self.phoneTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入手机号码"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if(![GTool valiMobile:self.phoneTextField.text]){
        [SVProgressHUD showInfoWithStatus:@"手机号码格式错误"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if([self.verfiyTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if([self.pwdTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入登录密码"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    
    button.enabled = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"mobileNo"] = self.phoneTextField.text;
    dic[@"msgCode"] = self.verfiyTextField.text;
    dic[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
    dic[@"password"] = self.pwdTextField.text;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kChangeMobile RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"恭喜您，修改成功！"];
            self.verfiyTextField.text = @"";
            self.phoneTextField.text = @"";
            self.pwdTextField.text = @"";
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"msg"]]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        button.enabled = YES;
    });
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.phoneTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.phoneTextField.text.length >= 11) {
            self.phoneTextField.text = [textField.text substringToIndex:11];
            return NO;
        }
    }
    if (textField == self.verfiyTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.verfiyTextField.text.length >= 4) {
            self.verfiyTextField.text = [textField.text substringToIndex:4];
            return NO;
        }
    }
    if (textField == self.pwdTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.pwdTextField.text.length >= 12) {
            self.pwdTextField.text = [textField.text substringToIndex:12];
            return NO;
        }
    }
    return YES;
}

@end
