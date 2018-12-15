//
//  GNewAddBankCardVc.m
//  QuCai
//
//  Created by mac on 2017/7/16.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GNewAddBankCardVc.h"
#import "GBindingCardListVc.h"

@interface GNewAddBankCardVc ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *tempArray;

@property (nonatomic, strong) UITextField *realNameTextField;
@property (nonatomic, strong) UITextField *carcNumberTextField;
@property (nonatomic, strong) UITextField *bankAddressTextField;
@property (nonatomic, strong) UITextField *moneyPwdTextField;
@property (nonatomic, strong) NSString *bankCodeString;

@end

@implementation GNewAddBankCardVc

- (void) onCreate {
    
    [self setupNav];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    
    [self buildView:self.view];
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"新增银行卡";
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
        make.height.mas_equalTo(320);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor colorWithRed:183.0/255 green:183.0/255 blue:183.0/255 alpha:1];
    titleLabel.text = @"    为了您账户安全，真实姓名需要与绑定银行卡姓名一致";
    titleLabel.font = [UIFont systemFontOfSize:13.f];
    titleLabel.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(64);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *realNameLabel = [[UILabel alloc] init];
    [realNameLabel setText:@"真实姓名"];
    [realNameLabel setTextColor:[UIColor blackColor]];
    realNameLabel.textAlignment = NSTextAlignmentRight;
    [realNameLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:realNameLabel];
    [realNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_offset(80);
    }];
    
    self.realNameTextField = [[UITextField alloc] init];
    [self.realNameTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.realNameTextField setPlaceholder:@"请输入持卡人名字"];
    [self.realNameTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bgView addSubview:self.realNameTextField];
    [self.realNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.left.equalTo(realNameLabel.mas_right).offset(10);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(realNameLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *carcNumberLabel = [[UILabel alloc] init];
    [carcNumberLabel setText:@"银行卡号"];
    [carcNumberLabel setTextColor:[UIColor blackColor]];
    carcNumberLabel.textAlignment = NSTextAlignmentRight;
    [carcNumberLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:carcNumberLabel];
    [carcNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_offset(80);
    }];
    
    self.carcNumberTextField = [[UITextField alloc] init];
    [self.carcNumberTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.carcNumberTextField setPlaceholder:@"请输入银行卡号"];
    self.carcNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.carcNumberTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bgView addSubview:self.carcNumberTextField];
    [self.carcNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(carcNumberLabel.mas_right).offset(10);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carcNumberLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *bankTypeLabel = [[UILabel alloc] init];
    [bankTypeLabel setText:@"银行种类"];
    [bankTypeLabel setTextColor:[UIColor blackColor]];
    bankTypeLabel.textAlignment = NSTextAlignmentRight;
    [bankTypeLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:bankTypeLabel];
    [bankTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_offset(80);
    }];
    
    UITextField *bankTypeTextField = [[UITextField alloc] init];
    [bankTypeTextField setFont:[UIFont systemFontOfSize:14.f]];
    [bankTypeTextField setPlaceholder:@"选择银行种类"];
    [bankTypeTextField setEnabled:NO];
    [bankTypeTextField setTag:1121];
    [bankTypeTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bgView addSubview:bankTypeTextField];
    [bankTypeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(bankTypeLabel.mas_right).offset(10);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    
    UIImageView *rightImv = [[UIImageView alloc] init];
    [rightImv setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [bgView addSubview:rightImv];
    [rightImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bankTypeTextField);
        make.trailing.equalTo(bgView).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(10);
    }];
    
    UIButton *selectBankButton = [[UIButton alloc] init];
    [bgView addSubview:selectBankButton];
    [selectBankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bankTypeTextField);
        make.left.equalTo(@50);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    [selectBankButton addTarget:self action:@selector(selectBankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankTypeLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *bankAddressLabel = [[UILabel alloc] init];
    [bankAddressLabel setText:@"开户行地址"];
    [bankAddressLabel setTextColor:[UIColor blackColor]];
    bankAddressLabel.textAlignment = NSTextAlignmentRight;
    [bankAddressLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:bankAddressLabel];
    [bankAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_offset(80);
    }];
    
    self.bankAddressTextField = [[UITextField alloc] init];
    [self.bankAddressTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.bankAddressTextField setPlaceholder:@"请输入开户行地址"];
    [self.bankAddressTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bgView addSubview:self.bankAddressTextField];
    [self.bankAddressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(bankAddressLabel.mas_right).offset(10);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankAddressLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *moneyPwdLabel = [[UILabel alloc] init];
    [moneyPwdLabel setText:@"资金密码"];
    [moneyPwdLabel setTextColor:[UIColor blackColor]];
    moneyPwdLabel.textAlignment = NSTextAlignmentRight;
    [moneyPwdLabel setFont:[UIFont systemFontOfSize:14.f]];
    [bgView addSubview:moneyPwdLabel];
    [moneyPwdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom);
        make.left.equalTo(bgView);
        make.height.mas_equalTo(45);
        make.width.mas_offset(80);
    }];
    
    self.moneyPwdTextField = [[UITextField alloc] init];
    self.moneyPwdTextField.delegate = self;
    [self.moneyPwdTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.moneyPwdTextField setPlaceholder:@"资金密码"];
    self.moneyPwdTextField.secureTextEntry = YES;
    self.moneyPwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.moneyPwdTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bgView addSubview:self.moneyPwdTextField];
    [self.moneyPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom);
        make.left.equalTo(moneyPwdLabel.mas_right).offset(10);
        make.trailing.equalTo(bgView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bgView addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyPwdLabel.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *label5 = [[UILabel alloc] init];
    [label5 setFont:[UIFont systemFontOfSize:12.f]];
    label5.textColor = [UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1];
    label5.text = @"请绑定持卡人本人的银行卡并确认卡号,避免后期提款无法到账";
    label5.numberOfLines = 0;
    label5.lineBreakMode = NSLineBreakByWordWrapping;
    label5.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom).offset(30);
        make.leading.equalTo(view).offset(20);
        make.trailing.equalTo(view).offset(-20);
        make.height.mas_equalTo(30);
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
        make.top.equalTo(label5).offset(40);
        make.centerX.equalTo(view);
        make.width.equalTo(@200);
        make.height.mas_equalTo(42);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectBankButtonClick:(UIButton *)button{
    [self.carcNumberTextField resignFirstResponder];
    [self.realNameTextField resignFirstResponder];
    [self.bankAddressTextField resignFirstResponder];
    [self.moneyPwdTextField resignFirstResponder];
    
    XPFPickerView *picker = [[XPFPickerView alloc] init];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"UserCardList" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    
    self.tempArray = dataArrs;
    NSMutableArray *arrs = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataArrs.count; i++) {
        NSDictionary *dict = dataArrs[i];
        [arrs addObject:[dict objectForKey:@"bankName"]];
    }
    
    picker.array = [arrs copy];
    picker.title = @"银行列表";
    [picker show];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"XPFPickerView" object:nil];
}

- (void)getValue:(NSNotification *)notification {
    UITextField *text = [self.view viewWithTag:1121];
    [text setText:notification.object];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    for (int i = 0 ; i < self.tempArray.count; i++) {
        NSDictionary *dict = self.tempArray[i];
        if([[dict objectForKey:@"bankName"] isEqualToString:notification.object]){
            self.bankCodeString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bankCode"]];
        }
    }
}

- (void)nextButtonClick:(UIButton *)sender{
    
    if([self.realNameTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入真实姓名"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if(![GTool checkCardNo:self.carcNumberTextField.text]){
        [SVProgressHUD showInfoWithStatus:@"卡号格式错误，请重新输入"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.carcNumberTextField.text = @"";
        return;
    }
    if([self.bankCodeString isEqualToString:@""] || self.bankCodeString == nil){
        [SVProgressHUD showInfoWithStatus:@"请选择银行"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if([self.bankAddressTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入开户行地址"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.bankAddressTextField.text = @"";
        return;
    }
    if([self.moneyPwdTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入资金密码"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.moneyPwdTextField.text = @"";
        return;
    }
    if([self.moneyPwdTextField.text length] != 4){
        [SVProgressHUD showInfoWithStatus:@"资金密码错误"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.moneyPwdTextField.text = @"";
        return;
    }
    
    sender.enabled = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"提交中..."];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self addUserCard];
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
                    
                    [self addUserCard];
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

- (void)addUserCard{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    dic[@"cardUserName"] = self.realNameTextField.text;
    dic[@"cardNum"] = self.carcNumberTextField.text;
    dic[@"cardAddress"] = self.bankAddressTextField.text;
    dic[@"password"] = self.moneyPwdTextField.text;
    dic[@"bankCode"] = self.bankCodeString;

    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kAddUserCard RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([[responseObject objectForKey:@"msg"] isEqualToString:@"success"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"恭喜您，添加成功！"];
            [self.navigationController popToRootViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"错误码：%@",responseObject[@"msg"]]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.moneyPwdTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.moneyPwdTextField.text.length >= 4) {
            self.moneyPwdTextField.text = [textField.text substringToIndex:4];
            return NO;
        }
    }
    return YES;
}

@end
