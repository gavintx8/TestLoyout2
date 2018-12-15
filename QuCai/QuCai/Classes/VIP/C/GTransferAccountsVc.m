//
//  GTransferAccountsVc.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GTransferAccountsVc.h"
#import "GPayVc.h"
#import "GPlatModel.h"
#import "GChosePlatAlert.h"

@interface GTransferAccountsVc ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *outLabel;
@property (nonatomic, strong) UILabel *inLabel;
@property (nonatomic, copy) NSString *outLabelString;
@property (nonatomic, copy) NSString *inLabelString;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UIButton *transferMoneyBtn;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) GChosePlatAlert *alert;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *typeArray;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,assign)NSInteger typeIndex;
@property (nonatomic, copy) NSString *currentType;
@property (nonatomic, copy) NSString *currentTitle;
@property(nonatomic,assign)BOOL isIn;
@property(nonatomic,strong)NSMutableArray *dataArrs;

@end

@implementation GTransferAccountsVc

- (void) onCreate {
    
    [self initLoadData];
    
    [self setupNav];
    [self createUI];
}

- (void) onWillShow {
    self.navigationController.navigationBar.hidden = NO;
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

- (void)onWillDisappear{
    [SVProgressHUD dismiss];
}

- (void)rightBtnClick {
    
    GPayVc *payVc = [[GPayVc alloc] init];
    [self.navigationController pushViewController:payVc animated:YES];
}

- (void)initLoadData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FundPlatList" ofType:@"plist"];
    self.dataArrs = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<self.dataArrs.count; i++) {
        NSDictionary *dic = self.dataArrs[i];
        GPlatModel *model = [[GPlatModel alloc] init];
        model.image_url = [NSString stringWithFormat:@"%@",[dic objectForKey:@"image"]];
        model.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
        model.money = @"加载中...";
        [self.dataArray addObject:model];
    }
    
    [self loadData];
}

- (void)loadData {
    
    self.typeArray = [[NSMutableArray alloc] init];
    self.titleArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            NSInteger index = 0;
            [self searchBalance:index];
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
                    
                    NSInteger index = 0;
                    [self searchBalance:index];
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

- (void)searchBalance:(NSInteger)indexB{
    
    NSDictionary *dic = self.dataArrs[indexB];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"BType"] = [NSString stringWithFormat:@"%@",[dic objectForKey:@"BType"]];
    indexB++;
    [self.typeArray addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"BType"]]];
    [self.titleArray addObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]]];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetBalance RequestWay:kPOST withParamters:dict withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        NSDictionary *dict = [[NSDictionary alloc] init];
        dict = responseObject;

        GPlatModel *model = self.dataArray[indexB-1];
        model.money = [NSString stringWithFormat:@"%@",[dict objectForKey:@"balance"]];
        
        if (indexB == 2) {
            self.isIn = NO;
            self.currentType = [NSString stringWithFormat:@"%@",[dic objectForKey:@"BType"]];
            self.currentTitle = [NSString stringWithFormat:@"%@",[dic objectForKey:@"title"]];
            self.inLabel.text = [NSString stringWithFormat:@"%@（￥%@）",model.title,[GTool stringMoneyFamat:model.money]];
        }
        if (indexB == self.dataArrs.count) {
            [SVProgressHUD dismiss];
        }else{
            [self searchBalance:indexB];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
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
    
    if ([[SZUser shareUser] readUser] == nil) {
        self.outLabelString = [NSString stringWithFormat:@"¥0.00"];
    } else {
        self.outLabelString = [NSString stringWithFormat:@"%@", [[SZUser shareUser] readBalance]];
    }
    
    self.outLabel = [[UILabel alloc] init];
    self.outLabel.textColor = [UIColor colorWithRed:98.0/255 green:98.0/255 blue:98.0/255 alpha:1];
    self.outLabel.font = [UIFont systemFontOfSize:14.f];
    self.outLabel.text = [NSString stringWithFormat:@"主账户(¥%@)", [GTool stringMoneyFamat:self.outLabelString]];
    [contentView addSubview:self.outLabel];
    [self.outLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(20);
        make.centerY.equalTo(label1);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *imv1 = [[UIImageView alloc] init];
    [imv1 setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [contentView addSubview:imv1];
    [imv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(contentView).offset(-15);
        make.centerY.equalTo(label1);
        make.width.mas_offset(10);
        make.height.mas_offset(20);
    }];
    
    UIButton *outTranInButton = [[UIButton alloc] init];
    [contentView addSubview:outTranInButton];
    [outTranInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label1);
        make.left.equalTo(@50);
        make.trailing.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    [outTranInButton addTarget:self action:@selector(outTranInButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    UIImageView *imv2 = [[UIImageView alloc] init];
    [imv2 setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [contentView addSubview:imv2];
    [imv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(contentView).offset(-15);
        make.centerY.equalTo(label2);
        make.width.mas_offset(10);
        make.height.mas_offset(20);
    }];
    
    UIButton *inTranInButton = [[UIButton alloc] init];
    [contentView addSubview:inTranInButton];
    [inTranInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label2);
        make.left.equalTo(@50);
        make.trailing.equalTo(contentView);
        make.height.mas_equalTo(40);
    }];
    [inTranInButton addTarget:self action:@selector(inTranInButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
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
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(40);
    }];
    self.moneyTextField.delegate = self;
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.moneyTextField.textAlignment = NSTextAlignmentLeft;
    
    UIButton *allTranInButton = [[UIButton alloc] init];
    [allTranInButton setTitleColor:Title_Red forState:UIControlStateNormal];
    [allTranInButton setTitle:@"全部转入" forState:UIControlStateNormal];
    allTranInButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
    [contentView addSubview:allTranInButton];
    [allTranInButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label3);
        make.trailing.equalTo(contentView).offset(-10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    [allTranInButton addTarget:self action:@selector(allTranInButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.transferMoneyBtn = [GUIHelper getButton:@"确定转账" titleColor:[UIColor whiteColor] font:TXT_SIZE_15];
    [self.transferMoneyBtn setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateNormal];
    [self.view addSubview:self.transferMoneyBtn];
    [self.transferMoneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(30);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(38);
    }];
    self.transferMoneyBtn.layer.cornerRadius = 4.0;
    self.transferMoneyBtn.layer.masksToBounds = YES;
    [self.transferMoneyBtn addTarget:self action:@selector(transferMoneyClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.transferMoneyBtn setEnabled:YES];
    
    self.typeIndex = 1;
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

- (void)outTranInButtonClick:(UIButton *)sender{

    self.alert = [[GChosePlatAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andHeight:kSize(kScreenHeight - 300)];
    self.alert.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alert];
    [self.alert initData:self.dataArray];
    WEAKSELF
    [self.alert setClikeCall:^(NSInteger index) {
        weakSelf.typeIndex = index;
        if (weakSelf.typeArray.count > index) {
            weakSelf.currentType = weakSelf.typeArray[weakSelf.typeIndex];
            weakSelf.currentTitle = weakSelf.titleArray[weakSelf.typeIndex];
            GPlatModel *model = weakSelf.dataArray[index];
            if (![model.money isEqualToString:@"维护中"]) {
                if (index == 0) {
                    weakSelf.isIn = NO;
                    GPlatModel *model2 = weakSelf.dataArray[1];
                    weakSelf.inLabelString = [NSString stringWithFormat:@"%@", model2.money];
                    weakSelf.inLabel.text = [NSString stringWithFormat:@"%@(¥%@)", model2.title,[GTool stringMoneyFamat:model2.money]];
                }else{
                    weakSelf.isIn = YES;
                    GPlatModel *mode3 = weakSelf.dataArray[0];
                    weakSelf.inLabelString = [NSString stringWithFormat:@"%@", mode3.money];
                    weakSelf.inLabel.text = [NSString stringWithFormat:@"%@(¥%@)", mode3.title,[GTool stringMoneyFamat:mode3.money]];
                }
                weakSelf.outLabelString = [NSString stringWithFormat:@"%@", model.money];
                weakSelf.outLabel.text = [NSString stringWithFormat:@"%@(¥%@)", model.title,[GTool stringMoneyFamat:model.money]];
                [weakSelf.alert hideView];
            }
        }
    }];
    [self.alert showView];
}

- (void)inTranInButtonClick:(UIButton *)sender{
    
    self.alert = [[GChosePlatAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andHeight:kSize(kScreenHeight - 300)];
    self.alert.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:self.alert];
    [self.alert initData:self.dataArray];
    WEAKSELF
    [self.alert setClikeCall:^(NSInteger index) {
        if (index == 0) {
            weakSelf.typeIndex = 1;
        }else{
            weakSelf.typeIndex = index;
        }
        if (weakSelf.typeArray.count > index) {
            weakSelf.currentType = weakSelf.typeArray[index];
            weakSelf.currentTitle = weakSelf.titleArray[index];
            GPlatModel *model = weakSelf.dataArray[index];
            if (![model.money isEqualToString:@"维护中"]) {
                if (index == 0) {
                    weakSelf.isIn = YES;
                    GPlatModel *model2 = weakSelf.dataArray[1];
                    weakSelf.outLabelString = [NSString stringWithFormat:@"%@", model2.money];
                    weakSelf.outLabel.text = [NSString stringWithFormat:@"%@(¥%@)", model2.title,[GTool stringMoneyFamat:model2.money]];
                }else{
                    weakSelf.isIn = NO;
                    GPlatModel *mode3 = weakSelf.dataArray[0];
                    weakSelf.outLabelString = [NSString stringWithFormat:@"%@", mode3.money];
                    weakSelf.outLabel.text = [NSString stringWithFormat:@"%@(¥%@)", mode3.title,[GTool stringMoneyFamat:mode3.money]];
                }
                weakSelf.inLabelString = [NSString stringWithFormat:@"%@", model.money];
                weakSelf.inLabel.text = [NSString stringWithFormat:@"%@(¥%@)", model.title,[GTool stringMoneyFamat:model.money]];
                [weakSelf.alert hideView];
            }
        }
    }];
    [self.alert showView];
}

- (void)allTranInButtonClick:(UIButton *)sender{
    NSString *str = [self.outLabelString stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (str.doubleValue > 100000.00) {
        self.moneyTextField.text = [NSString stringWithFormat:@"%.2lf",100000.00];
    }else{
        self.moneyTextField.text = [NSString stringWithFormat:@"%.2lf",[str doubleValue]];
    }
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
}

- (void)transferMoney{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"userKey"] = [SZUser shareUser].readUser.userKey;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetToken RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if (![responseObject[@"msg"] isEqualToString:@"error"]) {
            NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
            dicInfo[@"credit"] = [NSString stringWithFormat:@"%d",[self.moneyTextField.text intValue]];
            dicInfo[@"type"] = self.typeArray[self.typeIndex];
            dicInfo[@"uuid"] = responseObject[@"msg"];
            dicInfo[@"isImgCode"] = @"0";
            
            NSString *transUrl = @"";
            if(self.isIn){
                transUrl = kTransFrom;
            }else{
                transUrl = kTransGame;
            }
            
            [SVProgressHUD setMinimumDismissTimeInterval:1.0];
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:transUrl RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
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

- (void)getTransInfo{
    
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    dic2[@"BType"] = self.currentType;
    
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetBalance RequestWay:kPOST withParamters:dic2 withToken:nil success:^(BOOL isSuccess, id responseObject) {

        NSDictionary *dict2 = [[NSDictionary alloc] init];
        dict2 = responseObject;
        if (dict2 != nil) {
            NSString *fromBalance = [NSString stringWithFormat:@"%@",[dict2 objectForKey:@"balance"]];
            
            NSMutableDictionary *dic3 = [NSMutableDictionary dictionary];
            dic3[@"BType"] = @"WALLET";

            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetBalance RequestWay:kPOST withParamters:dic3 withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
                NSDictionary *dict3 = [[NSDictionary alloc] init];
                dict3 = responseObject;
                if (dict3 != nil) {
                    NSString *walletBalance = [NSString stringWithFormat:@"%@",[dict3 objectForKey:@"balance"]];
                    if (self.isIn) {
                        self.outLabelString = [NSString stringWithFormat:@"%@", fromBalance];
                        self.outLabel.text = [NSString stringWithFormat:@"%@(¥%@)", self.currentTitle,[GTool stringMoneyFamat:fromBalance]];
                        
                        self.inLabelString = [NSString stringWithFormat:@"%@", walletBalance];
                        self.inLabel.text = [NSString stringWithFormat:@"主账户(¥%@)", [GTool stringMoneyFamat:walletBalance]];
                        
                        GPlatModel *model1 = self.dataArray[self.typeIndex];
                        model1.money = self.outLabelString;
                        GPlatModel *model2 = self.dataArray[0];
                        model2.money = self.inLabelString;
                        [[SZUser shareUser] saveBalance2:self.inLabelString];
                    }else{
                        self.outLabelString = [NSString stringWithFormat:@"%@", walletBalance];
                        self.outLabel.text = [NSString stringWithFormat:@"主账户(¥%@)", [GTool stringMoneyFamat:walletBalance]];
                        
                        self.inLabelString = [NSString stringWithFormat:@"%@", fromBalance];
                        self.inLabel.text = [NSString stringWithFormat:@"%@(¥%@)", self.currentTitle,[GTool stringMoneyFamat:fromBalance]];
                    
                        GPlatModel *model1 = self.dataArray[self.typeIndex];
                        model1.money = self.inLabelString;
                        GPlatModel *model2 = self.dataArray[0];
                        model2.money = self.outLabelString;
                        [[SZUser shareUser] saveBalance2:self.outLabelString];
                    }
                }
                [SVProgressHUD dismiss];
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

@end
