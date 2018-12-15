//
//  GTransferAccounts.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GTransferAccounts.h"
#import "GPayVc.h"
#import "GEnterGameVc.h"
#import "GEnterGameVc2.h"
#import "AppDelegate.h"
#import "GTabBarVc.h"

@interface GTransferAccounts ()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *outLabel;
@property (nonatomic, strong) UILabel *inLabel;
@property (nonatomic, copy) NSString *outLabelString;
@property (nonatomic, copy) NSString *inLabelString;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UIButton *transferMoneyBtn;
@property (nonatomic, strong) UIButton *enterGameBtn;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

@implementation GTransferAccounts

- (void)onCreate {
    
    [self setupNav];
    [self createUI];
    self.inLabelString = [NSString stringWithFormat:@"%@(¥加载中...)",self.fromName];
    self.inLabel.text = self.inLabelString;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    self.transferMoneyBtn.enabled = NO;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            
            [self getTransInfo];
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
                    
                    [self getTransInfo];
                    
                } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                    [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                }
            } failure:^(NSError *error) {
                self.transferMoneyBtn.enabled = YES;
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }
    } failure:^(NSError *error) {
        self.transferMoneyBtn.enabled = YES;
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)getTransInfo{
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    
    if([self.gameType isEqualToString:@"YOPLAY"] || [self.gameType isEqualToString:@"TASSPTA"]){
        
        dic2[@"BType"] = @"AGIN";
        
    }else{
        dic2[@"BType"] = self.gameType;
    }
    
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetBalance RequestWay:kPOST withParamters:dic2 withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        NSDictionary *dict = [[NSDictionary alloc] init];
        dict = responseObject;
        if (dict != nil) {
            
            NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
            dicM[@"BType"] = @"WALLET";
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetBalance RequestWay:kPOST withParamters:dicM withToken:nil success:^(BOOL isSuccess, id responseObject) {
                NSDictionary *dict = [[NSDictionary alloc] init];
                dict = responseObject;
                if([dict objectForKey:@"balance"] != nil){
                    [[SZUser shareUser] saveBalance2:[NSString stringWithFormat:@"%@",[dict objectForKey:@"balance"]]];
                    self.outLabelString = [NSString stringWithFormat:@"主账户(¥%@)", [GTool stringMoneyFamat:[SZUser shareUser].readBalance]];
                    self.outLabel.text = self.outLabelString;
                }
                self.transferMoneyBtn.enabled = YES;
            } failure:^(NSError *error) {
                self.transferMoneyBtn.enabled = YES;
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
            
            NSString *balance = [NSString stringWithFormat:@"%@",[dict objectForKey:@"balance"]];
            self.inLabel.text = [NSString stringWithFormat:@"%@(¥%@)",self.fromName,[GTool stringMoneyFamat:balance]];
        }
    } failure:^(NSError *error) {
        self.transferMoneyBtn.enabled = YES;
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)onWillShow {
    
}

- (void)onWillDisappear {
    
    [SVProgressHUD dismiss];
}

- (void)onDidAppear {
    
}

- (void)setupNav {
    
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"财务互转";
    UIButton* rightBtn= [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    [rightBtn setTitle:@"快速存款" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = TXT_SIZE_15;
    UIBarButtonItem* rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationItem setRightBarButtonItem:rightBtnItem];
}

- (void)rightBtnClick {
    
    GPayVc *payVc = [[GPayVc alloc] init];
    [self.navigationController pushViewController:payVc animated:YES];
}

- (void)createUI {
    
    UIView *contentView = [GUIHelper getViewWithColor:[UIColor whiteColor]];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(KNavBarHeight + 20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(160);
    }];
    contentView.userInteractionEnabled = YES;
    
    
    UIView *lineView1 = [GUIHelper getViewWithColor:[UIColor lightGrayColor]];
    [contentView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UIView *lineView2 = [GUIHelper getViewWithColor:[UIColor lightGrayColor]];
    [contentView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(160/3);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UIView *lineView3 = [GUIHelper getViewWithColor:[UIColor lightGrayColor]];
    [contentView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(160/3);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel *label1 = [GUIHelper getLabel:@"转出" andFont:TXT_SIZE_14 andTextColor:[UIColor colorWithHexStr:@"#000000"]];
    [contentView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView1.mas_bottom).offset(160/6 - 6);
        make.left.equalTo(lineView1.mas_left).offset(15);
    }];
    
    if ([[SZUser shareUser] readBalance] == nil) {
        self.outLabelString = [NSString stringWithFormat:@"主账户(¥0.00)"];
    } else {
        self.outLabelString = [NSString stringWithFormat:@"主账户(¥%@)", [GTool stringMoneyFamat:[SZUser shareUser].readBalance]];
    }
    
    self.outLabel = [GUIHelper getLabel:self.outLabelString andFont:TXT_SIZE_14 andTextColor:[UIColor darkGrayColor]];
    [contentView addSubview:self.outLabel];
    [self.outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(20);
        make.centerY.equalTo(label1);
    }];
    
    UILabel *label2 = [GUIHelper getLabel:@"转入" andFont:TXT_SIZE_14 andTextColor:[UIColor colorWithHexStr:@"#000000"]];
    [contentView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(160/6 - 6);
        make.left.equalTo(lineView2.mas_left).offset(15);
    }];
    
    self.moneyLabel = [GUIHelper getLabel:@"0.00" andFont:TXT_SIZE_14 andTextColor:[UIColor colorWithHexStr:@"#000000"]];
    
    self.inLabel = [GUIHelper getLabel:self.inLabelString andFont:TXT_SIZE_14 andTextColor:[UIColor darkGrayColor]];
    [contentView addSubview:self.inLabel];
    [self.inLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right).offset(20);
        make.centerY.equalTo(label2);
    }];
    
    UILabel *label3 = [GUIHelper getLabel:@"金额" andFont:TXT_SIZE_14 andTextColor:[UIColor colorWithHexStr:@"#000000"]];
    [contentView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView3.mas_bottom).offset(160/6 - 6);
        make.left.equalTo(lineView3.mas_left).offset(15);
    }];
    
    self.moneyTextField = [GUIHelper getTextField:[UIColor darkGrayColor] andFont:TXT_SIZE_14 andPlaceholder:@"金额"];
    [contentView addSubview:self.moneyTextField];
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label3.mas_right).offset(20);
        make.centerY.equalTo(label3);
        make.width.mas_equalTo(350);
        make.height.mas_equalTo(40);
    }];
    self.moneyTextField.delegate = self;
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.moneyTextField.textAlignment = NSTextAlignmentLeft;
    
    self.transferMoneyBtn = [GUIHelper getButton:@"确定转账" titleColor:[UIColor whiteColor] font:TXT_SIZE_15];
    [self.transferMoneyBtn setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateNormal];
    [self.view addSubview:self.transferMoneyBtn];
    [self.transferMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(30);
        make.right.equalTo(self.view.mas_centerX).offset(-15);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(38);
    }];
    self.transferMoneyBtn.layer.cornerRadius = 4.0;
    self.transferMoneyBtn.layer.masksToBounds = YES;
    [self.transferMoneyBtn addTarget:self action:@selector(transferMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.transferMoneyBtn setEnabled:YES];
    
    self.enterGameBtn = [GUIHelper getButton:@"直接游戏" titleColor:[UIColor colorWithHexStr:@"#000000"] font:TXT_SIZE_15];
    [self.enterGameBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [self.view addSubview:self.enterGameBtn];
    [self.enterGameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.transferMoneyBtn);
        make.left.equalTo(self.view.mas_centerX).offset(15);
        make.width.mas_equalTo(88);
        make.height.mas_equalTo(38);
    }];
    self.enterGameBtn.layer.cornerRadius = 4.0;
    self.enterGameBtn.layer.masksToBounds = YES;
    [self.enterGameBtn addTarget:self action:@selector(enterGameClick:) forControlEvents:UIControlEventTouchUpInside];
    self.enterGameBtn.layer.borderWidth = 0.5;
    
    CGColorSpaceRef colorSpaceRefss = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorss = CGColorCreate(colorSpaceRefss, (CGFloat[]){51/255.0,51/255.0,51/255.0,1});
    self.enterGameBtn.layer.borderColor = colorss;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.moneyTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.moneyTextField.text.length >= 6) {
            self.moneyTextField.text = [textField.text substringToIndex:6];
            return NO;
        }
    }
    return YES;
}

- (void)transferMoneyClick:(UIButton *)sender{
    sender.enabled = NO;
    if(![self.moneyTextField.text isEqualToString:@""]){
        
        if([self.moneyTextField.text intValue] < 1 || [self.moneyTextField.text intValue] > 100000){
            [SVProgressHUD showInfoWithStatus:@"输入金额范围1~100000元"];
            [SVProgressHUD dismissWithDelay:0.5];
            self.moneyTextField.text = @"";
            sender.enabled = YES;
            return;
        }
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [SVProgressHUD showWithStatus:@"转账中..."];
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
            
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                
                [self transferMoney];
            }else{
                NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
                dicInfo[@"tname"] = [SZUser shareUser].readUser.userName;
                dicInfo[@"cagent"] = [[SZUser shareUser] readPlatCodeLink];
                NSString *pwd = [SZUser shareUser].readUser.password;
                dicInfo[@"tpwd"] = pwd;
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
                        user.password = pwd;
                        [[SZUser shareUser] saveLogin];
                        [[SZUser shareUser] saveUser];
                        
                        [self transferMoney];
                    } else if ([responseObject[@"status"] isEqualToString:@"faild"]) {
                        [SVProgressHUD showErrorWithStatus:responseObject[@"errmsg"]];
                    }
                    [SVProgressHUD dismiss];
                } failure:^(NSError *error) {
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
                }];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"转账失败"];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请填写金额再转账"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
}

- (void)transferMoney{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userKey"] = [SZUser shareUser].readUser.userKey;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetToken RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if (![responseObject[@"msg"] isEqualToString:@"error"]) {
            NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
            dicInfo[@"credit"] = self.moneyTextField.text;
            dicInfo[@"type"] = self.gameType;
            dicInfo[@"uuid"] = responseObject[@"msg"];
            dicInfo[@"isImgCode"] = @"0";
            
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kTransGame RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
                if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                    
                    [self getTransInfo];
                    self.moneyTextField.text = @"";
                    [SVProgressHUD showSuccessWithStatus:@"转账成功！"];
                } else if ([responseObject[@"msg"] isEqualToString:@"01"]) {
                    [SVProgressHUD showErrorWithStatus:@"转账平台错误"];
                }else if ([responseObject[@"msg"] isEqualToString:@"02"]) {
                    [SVProgressHUD showErrorWithStatus:@"转账金额错误"];
                }else if ([responseObject[@"msg"] isEqualToString:@"03"]) {
                    [SVProgressHUD showErrorWithStatus:@"token验证失败"];
                }else if ([responseObject[@"msg"] isEqualToString:@"05"]) {
                    [SVProgressHUD showErrorWithStatus:@"转账未完成,请稍后再试"];
                }else if ([responseObject[@"msg"] isEqualToString:@"06"]) {
                    [SVProgressHUD showErrorWithStatus:@"余额不足"];
                } else if ([responseObject[@"msg"] isEqualToString:@"process"]) {
                    [SVProgressHUD showErrorWithStatus:@"维护中"];
                }else{
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"系统错误,请稍后再试,错误码：%@",responseObject[@"msg"]]];
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


- (void)enterGameClick:(UIButton *)sender{
    sender.enabled = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [SVProgressHUD showWithStatus:@"进入游戏"];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            
            [self enterGame:dic];
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
                    [[SZUser shareUser] saveLogin];
                    [[SZUser shareUser] saveUser];
                    
                    [self enterGame:dic];
                    
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
}

- (void)enterGame:(NSMutableDictionary *)dic{
    
    if([self.gameType isEqualToString:@"IGPJ"]){
        if([self.platformName isEqualToString:@"六合彩"]){
            dic[@"gameType"] = @"IGPJLOTTO";
        }else{
            dic[@"gameType"] = @"IGPJLOTTERY";
        }
    }else if([self.gameType isEqualToString:@"IG"]){
        if([self.platformName isEqualToString:@"六合彩"]){
            dic[@"gameType"] = @"IGLOTTO";
        }else{
            dic[@"gameType"] = @"IGLOTTERY";
        }
    }else{
        dic[@"gameType"] = self.gameType;
    }
    if([self.platformName isEqualToString:@"AG捕鱼"]){
        dic[@"gameType"] = @"AGBY";
    }
    dic[@"gameID"] = self.gameID;
    
    if([self.gameType isEqualToString:@"VG"]){
        dic[@"model"] = @"2";
    }else if([self.gameType isEqualToString:@"PT"]){
        dic[@"model"] = @"mobile";
    }else{
        dic[@"model"] = @"MB";
    }
    
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kenterGame RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        NSString *urlStr = responseObject[@"msg"];
        
        if ([urlStr isEqualToString:@"error"]) {
            [SVProgressHUD showErrorWithStatus:@"系统错误"];
        }else if([urlStr isEqualToString:@"process"]) {
            [SVProgressHUD showInfoWithStatus:@"维护中"];
        }else{
            if([self.gameType isEqualToString:@"SB"]){
                GEnterGameVc2 *enterGameVc = [[GEnterGameVc2 alloc] init];
                enterGameVc.urlStr = urlStr;
                [self.navigationController pushViewController:enterGameVc animated:YES];
            }else if([self.gameType isEqualToString:@"VG"] && [self.gameID isEqualToString:@"1000"]){
                GEnterGameVc2 *enterGameVc = [[GEnterGameVc2 alloc] init];
                enterGameVc.urlStr = urlStr;
                [self.navigationController pushViewController:enterGameVc animated:YES];
            }else if([self.gameType isEqualToString:@"BBIN"] || [self.gameType isEqualToString:@"PT"]){
                if (@available(iOS 10.0, *)) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
                    }];
                } else {}
            }else{
                GEnterGameVc *enterGameVc = [[GEnterGameVc alloc] init];
                enterGameVc.urlStr = urlStr;
                [self.navigationController pushViewController:enterGameVc animated:YES];
            }
            [SVProgressHUD dismiss];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

@end
