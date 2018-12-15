//
//  GFooterScanView.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GFooterScanView.h"

@interface GFooterScanView ()

@property (nonatomic, assign) BOOL isQuotaSelect;
@property (nonatomic, strong) UIImageView *imvQRCode;
@property (nonatomic, strong) UIView *viewTemp;
@property (nonatomic, strong) UILabel *quotaLabel;
@property (nonatomic, strong) NSString *minquota;
@property (nonatomic, strong) NSString *maxquota;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UITextField *orderTextField;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *sid;

@end

@implementation GFooterScanView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.type = @"1";
        self.isQuotaSelect = YES;
        [self createUI];
    }
    return self;
}

#pragma mark - Setter Getter Methods

- (void)createUI{
    
    UIView *bgView = [[UIView alloc] init];
    bgView.tag = 10000;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(5);
        make.left.bottom.right.mas_equalTo(self);
    }];
    
    [self buildPayView:bgView];
    [self buildMoneyView:bgView];
    [self buildBottomView:bgView];
    
    self.viewTemp = [[UIView alloc] init];
    self.viewTemp.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [bgView addSubview:self.viewTemp];
    UIButton *myButton = [self viewWithTag:101];
    [self.viewTemp mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@600);
        make.left.right.equalTo(bgView);
        make.top.equalTo(myButton.mas_bottom);
    }];
    [self tipView:self.viewTemp];
    
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    dicInfo[@"type"] = @"1";
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetQRCode RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
        
        if(responseObject != nil){
            if ([responseObject[@"msg"] isEqualToString:@"暂无可选二维码，联系管理员配置！"]) {
                self.viewTemp.hidden = NO;
            }else{
                self.viewTemp.hidden = YES;
                self.minquota = responseObject[@"minquota"];
                self.maxquota = responseObject[@"maxquota"];
                self.sid = [NSString stringWithFormat:@"%@",responseObject[@"id"]];
                [self.imvQRCode sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"accountimg"]]]];
            }
        }
        
        [SVProgressHUD dismiss];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)buildPayView:(UIView *)bgView{
    
    UIView *payView = [[UIView alloc] init];
    [payView setTag:100];
    [bgView addSubview:payView];
    [payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bgView);
        make.height.mas_equalTo(240);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [payView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(payView);
        make.height.mas_equalTo(5);
    }];
    
    UIButton *btnPay1 = [self createButtonTag:@"支付宝" and:101];
    [payView addSubview:btnPay1];
    [btnPay1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payView).offset(5);
        make.leading.equalTo(payView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    self.payNumber = GPayScanNumber1;
    [btnPay1 setTitleColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1] forState:UIControlStateNormal];
    
    UILabel *bottomLabel1 = [[UILabel alloc] init];
    bottomLabel1.tag = 201;
    [bottomLabel1 setBackgroundColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1]];
    [payView addSubview:bottomLabel1];
    [bottomLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btnPay1.mas_bottom);
        make.leading.equalTo(payView);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    UIButton *btnPay2 = [self createButtonTag:@"微信" and:102];
    [payView addSubview:btnPay2];
    [btnPay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payView).offset(5);
        make.centerX.equalTo(payView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    UILabel *bottomLabel2 = [[UILabel alloc] init];
    bottomLabel2.tag = 202;
    [bottomLabel2 setBackgroundColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1]];
    [payView addSubview:bottomLabel2];
    [bottomLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btnPay2.mas_bottom);
        make.centerX.equalTo(payView);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    bottomLabel2.hidden = YES;
    
    UIButton *btnPay3 = [self createButtonTag:@"财付通" and:103];
    [payView addSubview:btnPay3];
    [btnPay3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payView).offset(5);
        make.trailing.equalTo(payView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    UILabel *bottomLabel3 = [[UILabel alloc] init];
    bottomLabel3.tag = 203;
    [bottomLabel3 setBackgroundColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1]];
    [payView addSubview:bottomLabel3];
    [bottomLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btnPay3.mas_bottom);
        make.trailing.equalTo(payView);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    bottomLabel3.hidden = YES;
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [payView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payView).offset(45);
        make.left.right.equalTo(payView);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *serviceLabel = [[UILabel alloc] init];
    [serviceLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [serviceLabel setText:@"只能扫描支付哦，如有疑问请联系"];
    [serviceLabel setFont:[UIFont systemFontOfSize:14.f]];
    [payView addSubview:serviceLabel];
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.leading.equalTo(payView).offset(20);
        make.height.mas_equalTo(35);
    }];
    
    UIButton *serviceButton = [self createButtonTag:@"在线客服" and:104];
    [serviceButton setImage:[UIImage imageNamed:@"icon_kefu_xiao"] forState:UIControlStateNormal];
    [payView addSubview:serviceButton];
    [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(serviceLabel.mas_right);
        make.height.mas_equalTo(35);
    }];
    [serviceButton setTitleColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1] forState:UIControlStateNormal];
    [serviceButton addTarget:self action:@selector(serviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [payView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(serviceLabel.mas_bottom);
        make.left.right.equalTo(payView);
        make.height.mas_equalTo(10);
    }];
    
    self.imvQRCode = [[UIImageView alloc] init];
    [payView addSubview:self.imvQRCode];
    [self.imvQRCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom).offset(10);
        make.centerX.equalTo(payView);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [payView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(payView);
        make.height.mas_equalTo(1);
    }];
}

- (UIButton *)createButtonTag:(NSString *)title and:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [btn setTag:tag];
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)payButtonClick:(UIButton *)button{
    for (int i = 101; i < 104; i++) {
        if (button.tag == i) {
            [button setTitleColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1] forState:UIControlStateNormal];
        }else{
            UIButton *myButton = [self viewWithTag:i];
            [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
        }
    }
    if (button.tag == 101) {
        self.type = @"1";
        UILabel *label1 = [self viewWithTag:201];
        label1.hidden = NO;
        UILabel *label2 = [self viewWithTag:202];
        label2.hidden = YES;
        UILabel *label3 = [self viewWithTag:203];
        label3.hidden = YES;
    }
    if (button.tag == 102) {
        self.type = @"2";
        UILabel *label1 = [self viewWithTag:201];
        label1.hidden = YES;
        UILabel *label2 = [self viewWithTag:202];
        label2.hidden = NO;
        UILabel *label3 = [self viewWithTag:203];
        label3.hidden = YES;
    }
    if (button.tag == 103) {
        self.type = @"3";
        UILabel *label1 = [self viewWithTag:201];
        label1.hidden = YES;
        UILabel *label2 = [self viewWithTag:202];
        label2.hidden = YES;
        UILabel *label3 = [self viewWithTag:203];
        label3.hidden = NO;
    }
    
    UIView *bankView = [self viewWithTag:10001];
    
    switch (button.tag) {
        case 101:{
            self.payNumber = GPayScanNumber1;
            [bankView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@55);
            }];
            bankView.hidden = NO;
        }
            break;
        case 102:{
            self.payNumber = GPayScanNumber2;
            [bankView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@0);
            }];
            bankView.hidden = YES;
        }
            break;
        case 103:{
            self.payNumber = GPayScanNumber3;
            [bankView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@0);
            }];
            bankView.hidden = YES;
        }
            break;
    }
    
    button.enabled = NO;
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    dicInfo[@"type"] = self.type;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetQRCode RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if(responseObject != nil){
            if ([responseObject[@"msg"] isEqualToString:@"暂无可选二维码，联系管理员配置！"]) {
                self.viewTemp.hidden = NO;
            }else{
                self.viewTemp.hidden = YES;
                self.minquota = responseObject[@"minquota"];
                self.maxquota = responseObject[@"maxquota"];
                self.sid = [NSString stringWithFormat:@"%@",responseObject[@"id"]];
                [GTool setAttributeStringForPriceLabel:self.quotaLabel text:[NSString stringWithFormat:@"单笔限额(元)%d - %d",[self.minquota intValue],[self.maxquota intValue]]];
                [self.imvQRCode sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"accountimg"]]]];
            }
        }
        button.enabled = YES;
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)tipView:(UIView *)view{
    UIView *bgView = [[UIView alloc] init];
    
    bgView.backgroundColor = [UIColor whiteColor];
    [view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).offset(10);
        make.leading.equalTo(view).offset(10);
        make.trailing.equalTo(view).offset(-10);
        make.height.mas_equalTo(130);
    }];
    [bgView.layer setCornerRadius:5];
    bgView.layer.masksToBounds = YES;
    
    UIButton *tipButton = [self createButtonTag:@"暂无可选二维码，联系管理员配置" and:104];
    [tipButton setImage:[UIImage imageNamed:@"icon_tanhao"] forState:UIControlStateNormal];
    [bgView addSubview:tipButton];
    [tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.centerX.equalTo(bgView).offset(-15);
        make.left.equalTo(bgView).offset(40);
        make.height.mas_equalTo(35);
    }];
    [tipButton setTitleColor:[UIColor colorWithRed:148.0/255 green:148.0/255 blue:148.0/255 alpha:1] forState:UIControlStateNormal];
    
    UIButton *serviceButton = [self createButtonTag:@"在线客服" and:105];
    [serviceButton setImage:[UIImage imageNamed:@"icon_kefu_xiao"] forState:UIControlStateNormal];
    serviceButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [bgView addSubview:serviceButton];
    [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.left.equalTo(tipButton.mas_right).offset(-35);
        make.height.mas_equalTo(35);
    }];
    [serviceButton setTitleColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1] forState:UIControlStateNormal];
    [serviceButton addTarget:self action:@selector(serviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buildMoneyView:(UIView *)bgView{
    
    UIView *payView = [self viewWithTag:100];
    
    UIView *moneyView = [[UIView alloc] init];
    [moneyView setTag:1001];
    [bgView addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payView.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.equalTo(@90);
    }];
    
    UIView *bg1 = [[UIView alloc] init];
    [bg1 setTag:1002];
    [moneyView addSubview:bg1];
    [bg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [titleLabel setText:@"金额"];
    [titleLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bg1 addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg1);
        make.left.equalTo(bg1).offset(30);
        make.height.mas_equalTo(45);
    }];
    
    self.moneyTextField = [[UITextField alloc] init];
    [self.moneyTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.moneyTextField setTag:10111];
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.moneyTextField setPlaceholder:@"请输入金额"];
    [self.moneyTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bg1 addSubview:self.moneyTextField];
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg1);
        make.left.equalTo(titleLabel.mas_right).offset(10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(180);
    }];
    
    UIButton *quotaButton = [[UIButton alloc] init];
    [quotaButton setTitleColor:[UIColor colorWithRed:197.0/255 green:166.0/255 blue:122.0/255 alpha:1] forState:UIControlStateNormal];
    [quotaButton setTitle:@"限额说明" forState:UIControlStateNormal];
    quotaButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [quotaButton setTag:1234];
    [bg1 addSubview:quotaButton];
    [quotaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg1);
        make.right.equalTo(bg1).offset(-20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(80);
    }];
    [quotaButton addTarget:self action:@selector(quotaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [moneyView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView).offset(45);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(1);
    }];
    
    self.quotaLabel = [[UILabel alloc] init];
    [self.quotaLabel setBackgroundColor:[UIColor colorWithRed:221.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
    [self.quotaLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.quotaLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    self.quotaLabel.textAlignment = NSTextAlignmentRight;
    [GTool setAttributeStringForPriceLabel:self.quotaLabel text:[NSString stringWithFormat:@"单笔限额(元)%d - %d",[self.minquota intValue],[self.maxquota intValue]]];
    [self.quotaLabel setTag:1003];
    [moneyView addSubview:self.quotaLabel];
    [self.quotaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg1.mas_bottom);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(0);
    }];
    
    UIView *bg2 = [[UIView alloc] init];
    [bg2 setTag:1004];
    [moneyView addSubview:bg2];
    [bg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.quotaLabel.mas_bottom);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    [titleLabel2 setFont:[UIFont systemFontOfSize:14.f]];
    [titleLabel2 setText:@"订单号"];
    [titleLabel2 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bg2 addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg2);
        make.left.equalTo(bg2).offset(17);
        make.height.mas_equalTo(45);
    }];
    
    self.orderTextField = [[UITextField alloc] init];
    [self.orderTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.orderTextField setTag:10111];
    [self.orderTextField setPlaceholder:@"请输入订单号后四位"];
    [self.orderTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bg2 addSubview:self.orderTextField];
    [self.orderTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg2);
        make.left.equalTo(titleLabel2.mas_right).offset(10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(180);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bg2 addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bg2);
        make.height.mas_equalTo(1);
    }];
    
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bg2.mas_bottom);
    }];
}

- (void)quotaButtonClick:(UIButton *)button{
    
    
    UIView *moneyView = [self viewWithTag:1001];
    
    if (self.isQuotaSelect) {
        [self.quotaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@45);
        }];
        [moneyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@135);
        }];
        self.isQuotaSelect = NO;
    }else{
        [self.quotaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [moneyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@90);
        }];
        self.isQuotaSelect = YES;
    }
    
    [GTool setAttributeStringForPriceLabel:self.quotaLabel text:[NSString stringWithFormat:@"单笔限额(元)%d - %d",[self.minquota intValue],[self.maxquota intValue]]];
}

- (void)buildBottomView:(UIView *)bgView{
    
    UIView *moneyView = [self viewWithTag:1001];
    
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setTag:10002];
    [bottomView setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    [bgView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(220);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
    [nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateNormal];
    nextButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [nextButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [nextButton setTag:1122];
    [bottomView addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(20);
        make.centerX.equalTo(bottomView);
        make.width.mas_equalTo(kScreenWidth - 40);
        make.height.mas_equalTo(42);
    }];
    [nextButton.layer setCornerRadius:3];
    nextButton.layer.masksToBounds = YES;
    [nextButton addTarget:self action:@selector(nextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label1 = [[UILabel alloc] init];
    [label1 setFont:[UIFont systemFontOfSize:14.f]];
    [label1 setText:@"温馨提示"];
    [label1 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    label1.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nextButton.mas_bottom).offset(20);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *label2 = [[UILabel alloc] init];
    [label2 setFont:[UIFont systemFontOfSize:13.f]];
    [label2 setText:@"为确保您的款项及时到帐，请您留意以下几点："];
    [label2 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    label2.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(10);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    NSString *label_text1 = @" 1.若您支付遇到困难，可 点此 查看存款范例。";
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:label_text1];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text1.length)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:202.0/255 green:25.0/255 blue:30.0/255 alpha:1] range:NSMakeRange(14, 2)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(0, 13)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(16, 8)];
    UILabel *label3 = [[UILabel alloc] init];
    [label3 setFont:[UIFont systemFontOfSize:12.f]];
    label3.attributedText = attributedString1;
    label3.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(7);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    [label3 yb_addAttributeTapActionWithStrings:@[@"点此"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        if (self.clikeHelpCall) {
            self.clikeHelpCall(string);
        }
    }];
    
    
    UILabel *label4 = [[UILabel alloc] init];
    [label4 setFont:[UIFont systemFontOfSize:12.f]];
    [label4 setText:@" 2.若您支付过程中遇到问题未完成支付，请重新下单。"];
    [label4 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    label4.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(7);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    NSString *label_text2 = @" 3.支付遇到困难？联系在线客服获得帮助";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:202.0/255 green:25.0/255 blue:30.0/255 alpha:1] range:NSMakeRange(12, 4)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(0, 12)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(16, 4)];
    UILabel *label5 = [[UILabel alloc] init];
    [label5 setFont:[UIFont systemFontOfSize:12.f]];
    label5.attributedText = attributedString2;
    label5.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4.mas_bottom).offset(7);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    [label5 yb_addAttributeTapActionWithStrings:@[@"在线客服"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        if (self.clikeCall) {
            self.clikeCall(index);
        }
    }];
}

- (void)nextButtonClick:(UIButton *)button{
    
    if([self.moneyTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入存款金额"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if([self.moneyTextField.text intValue] < [self.minquota intValue]){
        [SVProgressHUD showInfoWithStatus:@"存款金额太少"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.moneyTextField.text = @"";
        return;
    }
    if([self.moneyTextField.text intValue] > [self.maxquota intValue]){
        [SVProgressHUD showInfoWithStatus:@"存款金额太大"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.moneyTextField.text = @"";
        return;
    }
    if([self.orderTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入后四位订单号"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    
    button.enabled = NO;
    
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    dicInfo[@"id"] = self.sid;
    dicInfo[@"orderNum"] = self.orderTextField.text;
    dicInfo[@"amount"] = self.moneyTextField.text;
    dicInfo[@"transfertime"] = [GTool GetCurrentDateTime];
    dicInfo[@"type"] = self.type;
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kGetOrder RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if([responseObject[@"status"] isEqualToString:@"success"]){
            
            self.orderTextField.text = @"";
            self.moneyTextField.text = @"";
            NSDictionary *dict = responseObject;
            if (self.clikeNextCall) {
                self.clikeNextCall(dict);
            }            
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        button.enabled = YES;
    } failure:^(NSError *error) {
        button.enabled = YES;
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

- (void)serviceButtonClick:(UIButton *)button{
    if (self.clikeCall) {
        self.clikeCall(button.tag);
    }
}

@end
