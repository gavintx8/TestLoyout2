//
//  GDrawMoneyVc.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GDrawMoneyVc.h"
#import "GSetinngDrawPwdVc.h"
#import "GNewAddBankCardVc.h"
#import "ContactServiceVc2.h"
#import "GBindingCardListVc.h"

@interface GDrawMoneyVc ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL isQuotaSelect;
@property (nonatomic, assign) BOOL isLoad;
@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, strong) NSString *cardIDString;

@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UILabel *daCodeLabel;
@property (nonatomic, strong) UILabel *finishDaCodeLabel;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UITextField *drawPwdTextField;
@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *bankCardLabel;
@property (nonatomic, strong) UIButton *nextButton;

@end

@implementation GDrawMoneyVc

- (void) onCreate {
    
    [self setupNav];
    
    self.isQuotaSelect = YES;
}

- (void) onWillShow {
    self.navigationController.navigationBar.hidden = NO;
    
    if(!self.isLoad){
        [self loadData];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)setupNav {
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    self.navigationItem.title = @"提款";
}

- (void)loadData{
    
    self.isLoad = YES;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [self checkDrawMoney];
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
                    
                    [self checkDrawMoney];
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

- (void)checkDrawMoney{
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckQkpwd RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if ([responseObject[@"msg"] isEqualToString:@"0"]) {
            
            [self buildView:self.view];
            
        } else if ([responseObject[@"msg"] isEqualToString:@"1"]) {
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetUserCard RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
                
                if ([responseObject count] > 0) {
                    self.tempArray = responseObject;
                    [self buildDrawView:self.view];
                    
                    self.bankNameLabel.text = [NSString stringWithFormat:@"%@",[responseObject[0] objectForKey:@"bank_name"]];
                    self.bankCardLabel.text = [NSString stringWithFormat:@"%@",[responseObject[0] objectForKey:@"card_num"]];
                    self.cardIDString = [NSString stringWithFormat:@"%@",[responseObject[0] objectForKey:@"id"]];
                    
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kSelectWithdrawConfig RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
                        
                        if ([[responseObject objectForKey:@"status"] isEqualToString:@"success"]) {
                            
                            self.balanceLabel.text = [NSString stringWithFormat:@"%@元",[[SZUser shareUser] readBalance]];
                            self.daCodeLabel.text = [NSString stringWithFormat:@"    %@",[responseObject objectForKey:@"marking_quantity"]];
                            self.finishDaCodeLabel.text = [NSString stringWithFormat:@"    %@",[responseObject objectForKey:@"user_quantity"]];
                        }
                        
                    } failure:^(NSError *error) {
                        [SVProgressHUD showErrorWithStatus:kNetError];
                    }];
                    
                }else{
                    [self buildAddCardView:self.view];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:kNetError];
            }];
            
            
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)buildView:(UIView *)view{
    
    self.bgView = [[UIView alloc] init];
    [self.bgView setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(KNavBarHeight2);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(300);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"申请提款需先设置提款密码,请先设置"];
    [titleLabel setTextColor:[UIColor colorWithRed:88.0/255 green:88.0/255 blue:88.0/255 alpha:1]];
    titleLabel.textAlignment = NSTextAlignmentRight;
    [titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [self.bgView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(120);
        make.centerX.equalTo(self.bgView);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundColor:BG_Nav];
    nextButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [nextButton setTitle:@"立即设置" forState:UIControlStateNormal];
    [nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [nextButton setTag:1122];
    [view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel).offset(60);
        make.centerX.equalTo(view);
        make.width.equalTo(@160);
        make.height.mas_equalTo(42);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)nextButtonClick:(UIButton *)button{
    
    GSetinngDrawPwdVc *drawVc = [[GSetinngDrawPwdVc alloc] init];
    self.isLoad = NO;
    [self.navigationController pushViewController:drawVc animated:YES];
}

- (void)buildAddCardView:(UIView *)view{
    
    self.bgView = [[UIView alloc] init];
    [self.bgView setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    [view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(KNavBarHeight2);
        make.left.right.equalTo(view);
        make.height.mas_equalTo(400);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.bgView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(80);
        make.trailing.equalTo(self.bgView).offset(-20);
        make.leading.equalTo(self.bgView).offset(20);
        make.height.mas_equalTo(180);
    }];
    [bottomView.layer setCornerRadius:5];
    bottomView.layer.masksToBounds = YES;
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.image = [UIImage imageNamed:@"icon_mBank"];
    [bottomView addSubview:imv];
    [imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.centerY.equalTo(bottomView);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"点击此处新增银行卡"];
    [titleLabel setTextColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1]];
    titleLabel.textAlignment = NSTextAlignmentRight;
    [titleLabel setFont:[UIFont systemFontOfSize:13.f]];
    [bottomView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(120);
        make.centerX.equalTo(bottomView);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [view addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bottomView);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *titleLabel2 = [[UILabel alloc] init];
    [titleLabel2 setText:@"请先添加银行卡,添加后即可进行转出提款"];
    [titleLabel2 setTextColor:[UIColor colorWithRed:88.0/255 green:88.0/255 blue:88.0/255 alpha:1]];
    titleLabel2.textAlignment = NSTextAlignmentRight;
    [titleLabel2 setFont:[UIFont systemFontOfSize:13.f]];
    [self.bgView addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView.mas_bottom).offset(20);
        make.centerX.equalTo(self.bgView);
        make.height.mas_equalTo(20);
    }];

}

- (void)addButtonClick:(UIButton *)button{
    
    GNewAddBankCardVc *addCardVc = [[GNewAddBankCardVc alloc] init];
    [self.navigationController pushViewController:addCardVc animated:YES];
}

- (void)buildDrawView:(UIView *)view{
    self.scrollView = [[UIScrollView alloc] init];
    [view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(KNavBarHeight);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.mas_offset(900);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
    titleLabel.text = @"到账银行卡";
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30);
        make.left.equalTo(self.contentView).offset(10);
        make.height.mas_offset(20);
    }];
    
    UIView *cardView = [[UIView alloc] init];
    cardView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(@200);
        make.height.mas_offset(120);
    }];
    [GTool dc_chageControlCircularWith:cardView AndSetCornerRadius:0 SetBorderWidth:1 SetBorderColor:Title_Red canMasksToBounds:YES];
    
    UILabel *line0 = [[UILabel alloc] init];
    line0.backgroundColor = [UIColor colorWithRed:199.0/255 green:198.0/255 blue:203.0/255 alpha:1];
    [cardView addSubview:line0];
    [line0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView).offset(80);
        make.left.equalTo(cardView);
        make.width.equalTo(@200);
        make.height.mas_offset(1);
    }];
    
    self.bankNameLabel = [[UILabel alloc] init];
    self.bankNameLabel.textColor = [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    self.bankNameLabel.font = [UIFont boldSystemFontOfSize:18.f];
    self.bankNameLabel.textAlignment = NSTextAlignmentCenter;
    [cardView addSubview:self.bankNameLabel];
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView).offset(30);
        make.left.equalTo(cardView);
        make.height.mas_offset(20);
        make.width.mas_offset(200);
    }];
    
    self.bankCardLabel = [[UILabel alloc] init];
    self.bankCardLabel.textColor = [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    self.bankCardLabel.font = [UIFont systemFontOfSize:12.f];
    self.bankCardLabel.textAlignment = NSTextAlignmentCenter;
    [cardView addSubview:self.bankCardLabel];
    [self.bankCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView).offset(90);
        make.left.equalTo(cardView);
        make.height.mas_offset(20);
        make.width.mas_offset(200);
    }];
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.image = [UIImage imageNamed:@"icon_xuanze"];
    [cardView addSubview:imv];
    [imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cardView.mas_right);
        make.bottom.equalTo(cardView.mas_bottom);
    }];
    
    UIButton *selectCardButton = [[UIButton alloc] init];
    [selectCardButton setTitle:@"更换银行卡" forState:UIControlStateNormal];
    [selectCardButton setTitleColor:Title_Red forState:UIControlStateNormal];
    [selectCardButton.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [selectCardButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.contentView addSubview:selectCardButton];
    [selectCardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView.mas_bottom).offset(10);
        make.left.equalTo(cardView.mas_left);
        make.height.mas_offset(40);
        make.right.equalTo(self.contentView);
    }];
    [selectCardButton addTarget:self action:@selector(selectCardButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *line1 = [[UILabel alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:199.0/255 green:198.0/255 blue:203.0/255 alpha:1];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(selectCardButton.mas_bottom).offset(20);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(1);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    titleLabel2.textColor = [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    titleLabel2.font = [UIFont boldSystemFontOfSize:14.f];
    titleLabel2.textAlignment = NSTextAlignmentRight;
    titleLabel2.text = @"账户余额";
    [self.contentView addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1).offset(15);
        make.left.equalTo(self.contentView);
        make.height.mas_offset(20);
        make.width.mas_offset(90);
    }];
    
    self.balanceLabel = [[UILabel alloc] init];
    self.balanceLabel.textColor = [UIColor colorWithRed:86.0/255 green:86.0/255 blue:86.0/255 alpha:1];
    self.balanceLabel.font = [UIFont systemFontOfSize:14.f];
    self.balanceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.balanceLabel];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1).offset(15);
        make.left.equalTo(titleLabel2.mas_right).offset(10);
        make.height.mas_offset(20);
    }];
    
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.balanceLabel.mas_bottom).offset(15);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(20);
    }];
    
    UILabel *titleLabel3 = [[UILabel alloc] init];
    titleLabel3.textColor = [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    titleLabel3.font = [UIFont boldSystemFontOfSize:14.f];
    titleLabel3.textAlignment = NSTextAlignmentRight;
    titleLabel3.text = @"要求打码量";
    [self.contentView addSubview:titleLabel3];
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(15);
        make.left.equalTo(self.contentView);
        make.height.mas_offset(20);
        make.width.mas_offset(90);
    }];
    
    self.daCodeLabel = [[UILabel alloc] init];
    self.daCodeLabel.textColor = [UIColor colorWithRed:86.0/255 green:86.0/255 blue:86.0/255 alpha:1];
    self.daCodeLabel.font = [UIFont systemFontOfSize:14.f];
    self.daCodeLabel.textAlignment = NSTextAlignmentLeft;
    self.daCodeLabel.backgroundColor = [UIColor colorWithRed:242.0/255 green:245.0/255 blue:249.0/255 alpha:1];
    [self.contentView addSubview:self.daCodeLabel];
    [self.daCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel3);
        make.left.equalTo(titleLabel3.mas_right).offset(10);
        make.height.mas_offset(30);
        make.right.equalTo(self.contentView);
    }];
    
    UILabel *line3 = [[UILabel alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:199.0/255 green:198.0/255 blue:203.0/255 alpha:1];
    [self.contentView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel3.mas_bottom).offset(15);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(1);
    }];
    
    UILabel *titleLabel4 = [[UILabel alloc] init];
    titleLabel4.textColor = [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    titleLabel4.font = [UIFont boldSystemFontOfSize:14.f];
    titleLabel4.textAlignment = NSTextAlignmentRight;
    titleLabel4.text = @"完成打码量";
    [self.contentView addSubview:titleLabel4];
    [titleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(15);
        make.left.equalTo(self.contentView);
        make.height.mas_offset(20);
        make.width.mas_offset(90);
    }];
    
    self.finishDaCodeLabel = [[UILabel alloc] init];
    self.finishDaCodeLabel.textColor = [UIColor colorWithRed:86.0/255 green:86.0/255 blue:86.0/255 alpha:1];
    self.finishDaCodeLabel.font = [UIFont systemFontOfSize:14.f];
    self.finishDaCodeLabel.textAlignment = NSTextAlignmentLeft;
    self.finishDaCodeLabel.backgroundColor = [UIColor colorWithRed:242.0/255 green:245.0/255 blue:249.0/255 alpha:1];
    [self.contentView addSubview:self.finishDaCodeLabel];
    [self.finishDaCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleLabel4);
        make.left.equalTo(titleLabel4.mas_right).offset(10);
        make.height.mas_offset(30);
        make.right.equalTo(self.contentView);
    }];
    
    UILabel *line4 = [[UILabel alloc] init];
    line4.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [self.contentView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel4.mas_bottom).offset(15);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(10);
    }];
    
    UILabel *titleLabel5 = [[UILabel alloc] init];
    titleLabel5.textColor = [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    titleLabel5.font = [UIFont boldSystemFontOfSize:14.f];
    titleLabel5.textAlignment = NSTextAlignmentRight;
    titleLabel5.text = @"提交金额";
    [self.contentView addSubview:titleLabel5];
    [titleLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom);
        make.left.equalTo(self.contentView);
        make.height.mas_offset(45);
        make.width.mas_offset(90);
    }];
    
    self.moneyTextField = [[UITextField alloc] init];
    [self.moneyTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.moneyTextField setTag:10111];
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.moneyTextField setPlaceholder:@"请输入 ￥100-500000"];
    [self.moneyTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.contentView addSubview:self.moneyTextField];
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom);
        make.left.equalTo(titleLabel5.mas_right).offset(10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(180);
    }];

    UIButton *quotaButton = [[UIButton alloc] init];
    [quotaButton setTitleColor:Title_Red forState:UIControlStateNormal];
    [quotaButton setTitle:@"限额说明" forState:UIControlStateNormal];
    quotaButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [quotaButton setTag:1234];
    [self.contentView addSubview:quotaButton];
    [quotaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(80);
    }];
    [quotaButton addTarget:self action:@selector(quotaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *quotaLabe = [[UILabel alloc] init];
    quotaLabe.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    quotaLabe.textColor = [UIColor colorWithRed:86.0/255 green:86.0/255 blue:86.0/255 alpha:1];
    quotaLabe.text = @"单笔限额(元)100 - 500000    ";
    quotaLabe.tag = 1003;
    quotaLabe.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:quotaLabe];
    [quotaLabe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quotaButton.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth - 20);
        make.height.mas_offset(0);
    }];
    
    UILabel *zwLabel = [[UILabel alloc] init];
    zwLabel.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    zwLabel.tag = 1004;
    [self.contentView addSubview:zwLabel];
    [zwLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quotaButton.mas_bottom);
        make.left.equalTo(quotaLabe.mas_right);
        make.width.mas_equalTo(20);
        make.height.mas_offset(0);
    }];
    
    UILabel *line5 = [[UILabel alloc] init];
    line5.backgroundColor = [UIColor colorWithRed:199.0/255 green:198.0/255 blue:203.0/255 alpha:1];
    [self.contentView addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quotaLabe.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(1);
    }];
    
    UILabel *titleLabel6 = [[UILabel alloc] init];
    titleLabel6.textColor = [UIColor colorWithRed:39.0/255 green:39.0/255 blue:39.0/255 alpha:1];
    titleLabel6.font = [UIFont boldSystemFontOfSize:14.f];
    titleLabel6.textAlignment = NSTextAlignmentRight;
    titleLabel6.text = @"提款密码";
    [self.contentView addSubview:titleLabel6];
    [titleLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line5.mas_bottom);
        make.left.equalTo(self.contentView);
        make.height.mas_offset(45);
        make.width.mas_offset(90);
    }];
    
    self.drawPwdTextField = [[UITextField alloc] init];
    self.drawPwdTextField.delegate = self;
    [self.drawPwdTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.drawPwdTextField setTag:10111];
    self.drawPwdTextField.secureTextEntry = YES;
    self.drawPwdTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.drawPwdTextField setPlaceholder:@"提款密码"];
    [self.drawPwdTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.contentView addSubview:self.drawPwdTextField];
    [self.drawPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line5.mas_bottom);
        make.left.equalTo(titleLabel6.mas_right).offset(10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(180);
    }];
    
    UILabel *line6 = [[UILabel alloc] init];
    line6.backgroundColor = [UIColor colorWithRed:199.0/255 green:198.0/255 blue:203.0/255 alpha:1];
    [self.contentView addSubview:line6];
    [line6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel6.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(1);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line6.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_offset(420);
    }];
    
    self.nextButton = [GUIHelper getButton:@"下一步" titleColor:[UIColor whiteColor] font:TXT_SIZE_15];
    [self.nextButton setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateNormal];
    [self.nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.nextButton setTag:1122];
    [view addSubview:self.nextButton];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(20);
        make.centerX.equalTo(view);
        make.width.equalTo(@200);
        make.height.mas_equalTo(42);
    }];
    [self.nextButton.layer setCornerRadius:3];
    self.nextButton.layer.masksToBounds = YES;
    [self.nextButton addTarget:self action:@selector(sumbitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel7 = [[UILabel alloc] init];
    titleLabel7.textColor = [UIColor colorWithRed:86.0/255 green:86.0/255 blue:86.0/255 alpha:1];
    titleLabel7.font = [UIFont systemFontOfSize:15.f];
    titleLabel7.textAlignment = NSTextAlignmentLeft;
    titleLabel7.text = @"提取遇到困难";
    [bottomView addSubview:titleLabel7];
    [titleLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nextButton.mas_bottom).offset(60);
        make.left.equalTo(bottomView).offset(20);
        make.height.mas_offset(20);
    }];
    
    NSString *label_text2 = @"联系 在线客服 获得帮助";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:202.0/255 green:25.0/255 blue:30.0/255 alpha:1] range:NSMakeRange(3, 4)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:86.0/255 green:86.0/255 blue:86.0/255 alpha:1] range:NSMakeRange(0, 2)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:86.0/255 green:86.0/255 blue:86.0/255 alpha:1] range:NSMakeRange(8, 4)];
    UILabel *titleLabel8 = [[UILabel alloc] init];
    titleLabel8.attributedText = attributedString2;
    titleLabel8.textAlignment = NSTextAlignmentLeft;
    [titleLabel8 setFont:[UIFont systemFontOfSize:15.f]];
    [bottomView addSubview:titleLabel8];
    [titleLabel8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel7.mas_bottom).offset(5);
        make.left.equalTo(bottomView).offset(20);
        make.height.mas_equalTo(20);
    }];
    [titleLabel8 yb_addAttributeTapActionWithStrings:@[@"在线客服"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        ContactServiceVc2 *csVc = [[ContactServiceVc2 alloc] init];
        [self.navigationController pushViewController:csVc animated:YES];
    }];
}

- (void)sumbitButtonClick:(UIButton *)sender{
    
    if([self.moneyTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入金额"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if([self.moneyTextField.text intValue] < 100){
        [SVProgressHUD showInfoWithStatus:@"输入100以上的金额"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if([self.moneyTextField.text intValue] > 500000){
        [SVProgressHUD showInfoWithStatus:@"输入金额太大"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if([self.drawPwdTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入提款密码"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.drawPwdTextField.text = @"";
        return;
    }
    if([self.drawPwdTextField.text length] != 4){
        [SVProgressHUD showErrorWithStatus:@"输入提款密码错误"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.drawPwdTextField.text = @"";
        return;
    }
    sender.enabled = NO;
    if(![self.moneyTextField.text isEqualToString:@""]){
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [SVProgressHUD showWithStatus:@"提交中..."];
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kCheckLogin RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
            
            if ([responseObject[@"msg"] isEqualToString:@"success"]) {
                
                [self drawMoney];
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
                        
                        [self drawMoney];
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
            [SVProgressHUD showErrorWithStatus:@"操作失败"];
        }];
    }else{
        [SVProgressHUD showErrorWithStatus:@"请填写金额再转账"];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
}

- (void)drawMoney{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"password"] = self.drawPwdTextField.text;
    dic[@"cardid"] = self.cardIDString;
    dic[@"credit"] = self.moneyTextField.text;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kWithDraw RequestWay:kPOST withParamters:dic withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"success"]) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功！请等待管理员审核"];
            self.moneyTextField.text = @"";
            self.drawPwdTextField.text = @"";
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)selectCardButtonClick:(UIButton *)button{
    GBindingCardListVc *csVc = [[GBindingCardListVc alloc] init];
    csVc.tempArray = self.tempArray;
    [self.navigationController pushViewController:csVc animated:YES];
}

- (void)quotaButtonClick:(UIButton *)button{
    UILabel *quotaLabel = [self.view viewWithTag:1003];
    UILabel *zwLabel = [self.view viewWithTag:1004];
    
    if (self.isQuotaSelect) {
        [quotaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
        [zwLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
        }];
        self.isQuotaSelect = NO;
    }else{
        [quotaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [zwLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        self.isQuotaSelect = YES;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.drawPwdTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        }else if (self.drawPwdTextField.text.length >= 4) {
            self.drawPwdTextField.text = [textField.text substringToIndex:4];
            return NO;
        }
    }
    return YES;
}

@end
