//
//  GSafeSettingVc.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GSafeSettingVc.h"
#import "GBindingPhoneVc.h"
#import "GSetinngDrawPwdVc.h"
#import "GSettingLoginPwdVc.h"
#import "GAddCardVc.h"
#import "GBindingCardListVc.h"

@interface GSafeSettingVc ()

@property (nonatomic, strong) UIButton *drawButton;
@property (nonatomic, strong) UIButton *cardButton;
@property (nonatomic, strong) UIButton *phoneButton;
@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, assign) BOOL isDrawPwd;

@end

@implementation GSafeSettingVc

- (void) onCreate {
    
    [self setupNav];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    
    [self buildView:self.view];
}

- (void)setupNav {
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"安全设置";
}

- (void) onWillShow {
    self.navigationController.navigationBar.hidden = NO;
    [self loadData];
}

- (void)loadData{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self getInitInfo];
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
                    
                    [self getInitInfo];
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
}

- (void)getInitInfo{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetUserCard RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        self.tempArray = [[NSMutableArray alloc] init];
        self.tempArray = responseObject;
        if (self.tempArray.count > 0) {
            NSDictionary *dict = self.tempArray[0];
            NSString *str = [dict objectForKey:@"card_num"];
            [self.cardButton setTitle:[NSString stringWithFormat:@"%@(%@)",[dict objectForKey:@"bank_name"],[str substringFromIndex:str.length - 4]] forState:UIControlStateNormal];
        }
            
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckQkpwd RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
            if ([responseObject[@"msg"] isEqualToString:@"0"]) {
                self.isDrawPwd = NO;
                [self.drawButton setTitle:@"未设置" forState:UIControlStateNormal];
            } else if ([responseObject[@"msg"] isEqualToString:@"1"]) {
                self.isDrawPwd = YES;
                [self.drawButton setTitle:@"已设置" forState:UIControlStateNormal];
            }else{
                [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
            }
            
            if (responseObject != nil) {
                NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
                [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetUserInfo RequestWay:kPOST withParamters:dict2 withToken:nil success:^(BOOL isSuccess, id responseObject) {
                    NSDictionary *dic2 = [[NSDictionary alloc] init];
                    dic2 = responseObject;
                    if (dic2 != nil) {
                        [self.phoneButton setTitle:[NSString stringWithFormat:@"%@",[dic2 objectForKey:@"mobile"]] forState:UIControlStateNormal];
                    }
                    [SVProgressHUD dismiss];
                } failure:^(NSError *error) {
                    [SVProgressHUD dismiss];
                    [SVProgressHUD showErrorWithStatus:kNetError];
                }];
            }
            
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:kNetError];
        }];

    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)buildView:(UIView *)view{
    
    UIView *line0 = [[UIView alloc] init];
    line0.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [view addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(KNavBarHeight);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *drawLabel = [[UILabel alloc] init];
    [drawLabel setText:@"提款密码"];
    [drawLabel setTextColor:[UIColor blackColor]];
    [drawLabel setFont:[UIFont systemFontOfSize:14.f]];
    [view addSubview:drawLabel];
    [drawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line0.mas_bottom);
        make.left.equalTo(view).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    self.drawButton = [self createButtonTag:@"" and:3064];
    [view addSubview:self.drawButton];
    [self.drawButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line0.mas_bottom);
        make.trailing.equalTo(view).offset(-30);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(200);
    }];
    [self.drawButton addTarget:self action:@selector(drawButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *rightImv = [[UIImageView alloc] init];
    [rightImv setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [view addSubview:rightImv];
    [rightImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(drawLabel);
        make.trailing.equalTo(view).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(10);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(drawLabel.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *loginLabel = [[UILabel alloc] init];
    [loginLabel setText:@"登录密码"];
    [loginLabel setTextColor:[UIColor blackColor]];
    [loginLabel setFont:[UIFont systemFontOfSize:14.f]];
    [view addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.left.equalTo(view).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    UIButton *loginButton = [self createButtonTag:@"" and:3064];
    [view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom);
        make.trailing.equalTo(view).offset(-30);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(200);
    }];
    [loginButton addTarget:self action:@selector(loginButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *rightImv2 = [[UIImageView alloc] init];
    [rightImv2 setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [view addSubview:rightImv2];
    [rightImv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(loginLabel);
        make.trailing.equalTo(view).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(10);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginLabel.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    [phoneLabel setText:@"手机号码"];
    [phoneLabel setTextColor:[UIColor blackColor]];
    [phoneLabel setFont:[UIFont systemFontOfSize:14.f]];
    [view addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(view).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    self.phoneButton = [self createButtonTag:@"" and:3064];
    [view addSubview:self.phoneButton];
    [self.phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.trailing.equalTo(view).offset(-30);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(200);
    }];
    [self.phoneButton addTarget:self action:@selector(phoneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *rightImv3 = [[UIImageView alloc] init];
    [rightImv3 setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [view addSubview:rightImv3];
    [rightImv3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneLabel);
        make.trailing.equalTo(view).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(10);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLabel.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *cardLabel = [[UILabel alloc] init];
    [cardLabel setText:@"银行卡"];
    [cardLabel setTextColor:[UIColor blackColor]];
    [cardLabel setFont:[UIFont systemFontOfSize:14.f]];
    [view addSubview:cardLabel];
    [cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(view).offset(20);
        make.height.mas_equalTo(45);
    }];
    
    self.cardButton = [self createButtonTag:@"尚未绑定" and:3064];
    [view addSubview:self.cardButton];
    [self.cardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.trailing.equalTo(view).offset(-30);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(200);
    }];
    [self.cardButton addTarget:self action:@selector(cardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *rightImv4 = [[UIImageView alloc] init];
    [rightImv4 setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [view addSubview:rightImv4];
    [rightImv4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cardLabel);
        make.trailing.equalTo(view).offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(10);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [view addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardLabel.mas_bottom);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(1);
    }];
}

- (void)drawButtonClick:(UIButton *)button{
    GSetinngDrawPwdVc *drawVc = [[GSetinngDrawPwdVc alloc] init];
    drawVc.isDrawPwd = self.isDrawPwd;
    [self.navigationController pushViewController:drawVc animated:YES];
}

- (void)loginButtonClick:(UIButton *)button{
    GSettingLoginPwdVc *loginVc = [[GSettingLoginPwdVc alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

- (void)phoneButtonClick:(UIButton *)button{
    GBindingPhoneVc *phoneVc = [[GBindingPhoneVc alloc] init];
    phoneVc.phone = self.phoneButton.titleLabel.text;
    [self.navigationController pushViewController:phoneVc animated:YES];
}

- (void)cardButtonClick:(UIButton *)button{
    if(self.tempArray.count == 0 && !self.isDrawPwd){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"请先设置提款密码" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            GSetinngDrawPwdVc *drawVc = [[GSetinngDrawPwdVc alloc] init];
            drawVc.isDrawPwd = self.isDrawPwd;
            [self.navigationController pushViewController:drawVc animated:YES];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if(self.tempArray.count == 0 && self.isDrawPwd){
        GAddCardVc *addCardVc = [[GAddCardVc alloc] init];
        [self.navigationController pushViewController:addCardVc animated:YES];
    }else{
        GBindingCardListVc *bcCardVc = [[GBindingCardListVc alloc] init];
        bcCardVc.tempArray = self.tempArray;
        [self.navigationController pushViewController:bcCardVc animated:YES];
    }
}

- (UIButton *)createButtonTag:(NSString *)title and:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [btn setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [btn setTag:tag];
    btn.layer.masksToBounds = YES;
    
    return btn;
}

@end
