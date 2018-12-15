//
//  GFooterBankHkView.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GFooterBankHkView.h"

@interface GFooterBankHkView ()

@property (nonatomic, assign) BOOL isQuotaSelect;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UITextField *moneyTextField;

@end

@implementation GFooterBankHkView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.isQuotaSelect = YES;
        self.type = @"1";
        [self createUI];
    }
    return self;
}

#pragma mark - Setter Getter Methods

- (void)createUI{
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(5);
        make.left.bottom.right.mas_equalTo(self);
    }];
    
    [self buildDepositList:bgView];
    [self buildMoneyView:bgView];
    [self buildBottomView:bgView];
}

- (void)buildDepositList:(UIView *)bgView{
    
    UIView *depositView = [[UIView alloc] init];
    [depositView setTag:10001];
    [bgView addSubview:depositView];
    [depositView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(100);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [depositView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(depositView);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [titleLabel setText:@"存款方式"];
    [titleLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [depositView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(depositView).offset(10);
        make.left.equalTo(depositView).offset(25);
        make.height.mas_equalTo(45);
    }];
    
    UIImageView *leftImv = [[UIImageView alloc] init];
    [leftImv setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [depositView addSubview:leftImv];
    [leftImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(depositView).offset(22);
        make.trailing.equalTo(depositView).offset(-10);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *bankButton = [[UIButton alloc] init];
    [bankButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bankButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    bankButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [bankButton setTag:1121];
    [bankButton setTitle:@"网银转账" forState:UIControlStateNormal];
    [depositView addSubview:bankButton];
    [bankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(depositView).offset(10);
        make.left.equalTo(depositView).offset(95);
        make.right.equalTo(depositView).offset(-30);
        make.height.mas_equalTo(45);
    }];
    [bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [depositView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(depositView);
        make.top.equalTo(depositView).offset(55);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    [titleLabel2 setFont:[UIFont systemFontOfSize:14.f]];
    [titleLabel2 setText:@"存款人姓名"];
    [titleLabel2 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [depositView addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(depositView).offset(55);
        make.left.equalTo(depositView).offset(10);
        make.height.mas_equalTo(45);
    }];
    
    self.nameTextField = [[UITextField alloc] init];
    [self.nameTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.nameTextField setTag:10110];
    [self.nameTextField setPlaceholder:@"请输入真实姓名"];
    [self.nameTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [depositView addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(depositView).offset(55);
        make.left.equalTo(titleLabel2.mas_right).offset(10);
        make.trailing.equalTo(depositView);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [depositView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(depositView);
        make.height.mas_equalTo(1);
    }];
}

- (void)bankButtonClick:(UIButton *)button{
    
    XPFPickerView *picker = [[XPFPickerView alloc] init];
    
    NSMutableArray *dataArrs = [NSMutableArray arrayWithObjects:@"网银转账",@"支付宝",@"财付通",@"微信",@"ATM自动柜员机",@"ATM现金入款",@"银行柜台", nil];
    
    picker.array = [dataArrs copy];
    picker.title = @"银行列表";
    [picker show];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"XPFPickerView" object:nil];
}

- (void)getValue:(NSNotification *)notification {
    UIButton *bankButton = [self viewWithTag:1121];
    [bankButton setTitle:notification.object forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    if([notification.object isEqualToString:@"网银转账"]){
        self.type = @"1";
    }else if([notification.object isEqualToString:@"支付宝"]){
        self.type = @"2";
    }else if([notification.object isEqualToString:@"财付通"]){
        self.type = @"3";
    }else if([notification.object isEqualToString:@"微信"]){
        self.type = @"4";
    }else if([notification.object isEqualToString:@"ATM自动柜员机"]){
        self.type = @"5";
    }else if([notification.object isEqualToString:@"ATM现金入款"]){
        self.type = @"6";
    }else if([notification.object isEqualToString:@"银行柜台"]){
        self.type = @"7";
    }
}

- (void)buildMoneyView:(UIView *)bgView{
    
    UIView *depositView = [self viewWithTag:10001];
    
    UIView *moneyView = [[UIView alloc] init];
    [moneyView setTag:10002];
    [bgView addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(depositView.mas_bottom);
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
        make.left.equalTo(bg1).offset(55);
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
    [quotaButton setTitleColor:Title_Red forState:UIControlStateNormal];
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
    
    UILabel *quotaLabel = [[UILabel alloc] init];
    [quotaLabel setBackgroundColor:[UIColor colorWithRed:221.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
    [quotaLabel setFont:[UIFont systemFontOfSize:14.f]];
    [quotaLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    quotaLabel.textAlignment = NSTextAlignmentRight;
    quotaLabel.numberOfLines = 0;
    [GTool setAttributeStringForPriceLabel:quotaLabel text:@" 单笔限额(元)100 - 2000000\n 每日限额(元)2000000"];
    [quotaLabel setTag:1003];
    [moneyView addSubview:quotaLabel];
    [quotaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg1.mas_bottom);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(0);
    }];
    
    UIView *bg2 = [[UIView alloc] init];
    [bg2 setTag:1004];
    [moneyView addSubview:bg2];
    [bg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(quotaLabel.mas_bottom);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(45);
    }];
    
    UIButton *moneyButton1 = [self createButtonTag2:@"100" and:201];
    [bg2 addSubview:moneyButton1];
    [moneyButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg2).offset(7);
        make.leading.equalTo(bg2).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButton2 = [self createButtonTag2:@"300" and:202];
    [bg2 addSubview:moneyButton2];
    [moneyButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg2).offset(7);
        make.left.equalTo(moneyButton1.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButton3 = [self createButtonTag2:@"500" and:203];
    [bg2 addSubview:moneyButton3];
    [moneyButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg2).offset(7);
        make.left.equalTo(moneyButton2.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButton4 = [self createButtonTag2:@"1000" and:204];
    [bg2 addSubview:moneyButton4];
    [moneyButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg2).offset(7);
        make.left.equalTo(moneyButton3.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButton5 = [self createButtonTag2:@"1500" and:205];
    [bg2 addSubview:moneyButton5];
    [moneyButton5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bg2).offset(7);
        make.left.equalTo(moneyButton4.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
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
    
    
    UILabel *quotaLabel = [self viewWithTag:1003];
    UIView *moneyView = [self viewWithTag:10002];
    
    if (self.isQuotaSelect) {
        [quotaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@60);
        }];
        [moneyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@150);
        }];
        self.isQuotaSelect = NO;
    }else{
        [quotaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0);
        }];
        [moneyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@90);
        }];
        self.isQuotaSelect = YES;
    }
}

- (UIButton *)createButtonTag2:(NSString *)title and:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [btn setTag:tag];
    btn.layer.masksToBounds = YES;
    [GTool dc_chageControlCircularWith:btn AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:[UIColor colorWithRed:223.0/255 green:225.0/255 blue:232.0/255 alpha:1] canMasksToBounds:YES];
    [btn addTarget:self action:@selector(moneyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)moneyButtonClick:(UIButton *)button{
    
    [self.nameTextField resignFirstResponder];
    [self.moneyTextField resignFirstResponder];
    
    for (int i = 201; i < 206; i++) {
        if (button.tag == i) {
            [button setTitleColor:[UIColor colorWithRed:202.0/255 green:25.0/255 blue:30.0/255 alpha:1] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithRed:249.0/255 green:228.0/255 blue:228.0/255 alpha:1]];
        }else{
            UIButton *myButton = [self viewWithTag:i];
            [myButton setBackgroundColor:[UIColor whiteColor]];
            [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
        }
    }
    
    UITextField *text = [self viewWithTag:10111];
    switch (button.tag) {
        case 201:{
            [text setText:@"100"];
        }
            break;
        case 202:{
            [text setText:@"300"];
        }
            break;
        case 203:{
            [text setText:@"500"];
        }
            break;
        case 204:{
            [text setText:@"1000"];
        }
            break;
        case 205:{
            [text setText:@"1500"];
        }
            break;
    }
}

- (void)buildBottomView:(UIView *)bgView{
    
    UIView *moneyView = [self viewWithTag:10002];
    
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setTag:10002];
    [bottomView setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    [bgView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(320);
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
    
    UILabel *label3 = [[UILabel alloc] init];
    [label3 setFont:[UIFont systemFontOfSize:12.f]];
    [label3 setText:@"1.每次存款前，请先至本页面查看最新的收款账户。"];
    [label3 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    label3.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(7);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *label4 = [[UILabel alloc] init];
    [label4 setFont:[UIFont systemFontOfSize:12.f]];
    [label4 setText:@"请勿自行存款至旧账户，若存款至旧账户，本公司将无法查收，恕不负责。"];
    label4.lineBreakMode = NSLineBreakByWordWrapping;
    label4.numberOfLines = 0;
    [label4 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    label4.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom);
        make.left.equalTo(bottomView).offset(10);
        make.width.mas_equalTo(kScreenWidth - 20);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *label5 = [[UILabel alloc] init];
    [label5 setFont:[UIFont systemFontOfSize:12.f]];
    [label5 setText:@"2.请使用同行存款，加快您的入款速度。"];
    [label5 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    label5.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label4.mas_bottom).offset(7);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *label6 = [[UILabel alloc] init];
    [label6 setFont:[UIFont systemFontOfSize:12.f]];
    [label6 setText:@"3.支持非本人开户账户进行存款。"];
    [label6 setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    label6.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label5.mas_bottom).offset(7);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    NSString *label_text1 = @"4.若您支付遇到困难，可 点此 查看存款范例。";
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:label_text1];
    [attributedString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text1.length)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:202.0/255 green:25.0/255 blue:30.0/255 alpha:1] range:NSMakeRange(13, 2)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(0, 12)];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(15, 8)];
    UILabel *label7 = [[UILabel alloc] init];
    [label7 setFont:[UIFont systemFontOfSize:12.f]];
    label7.attributedText = attributedString1;
    label7.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label7];
    [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label6.mas_bottom).offset(7);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    [label7 yb_addAttributeTapActionWithStrings:@[@"点此"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        if (self.clikeHelpCall) {
            self.clikeHelpCall(string);
        }
    }];

    NSString *label_text2 = @"支付遇到困难？联系在线客服获得帮助";
    NSMutableAttributedString *attributedString2 = [[NSMutableAttributedString alloc]initWithString:label_text2];
    [attributedString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, label_text2.length)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:202.0/255 green:25.0/255 blue:30.0/255 alpha:1] range:NSMakeRange(9, 4)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(0, 9)];
    [attributedString2 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] range:NSMakeRange(13, 4)];
    UILabel *label8 = [[UILabel alloc] init];
    [label8 setFont:[UIFont systemFontOfSize:12.f]];
    label8.attributedText = attributedString2;
    label8.textAlignment = NSTextAlignmentLeft;
    [bottomView addSubview:label8];
    [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label7.mas_bottom).offset(7);
        make.left.equalTo(bottomView).offset(10);
        make.height.mas_equalTo(20);
    }];
    [label8 yb_addAttributeTapActionWithStrings:@[@"在线客服"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
        if (self.clikeCall) {
            self.clikeCall(index);
        }
    }];
}

- (void)nextButtonClick:(UIButton *)button{
    
    if([self.nameTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入您的真实姓名"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if(![GTool isVaildRealName:self.nameTextField.text]){
        [SVProgressHUD showErrorWithStatus:@"您的姓名输入有误，请重新输入"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.nameTextField.text = @"";
        return;
    }
    
    if([self.moneyTextField.text isEqualToString:@""]){
        [SVProgressHUD showInfoWithStatus:@"请输入存款金额"];
        [SVProgressHUD dismissWithDelay:0.5];
        return;
    }
    if([self.moneyTextField.text intValue] < 100){
        [SVProgressHUD showInfoWithStatus:@"存款金额太少"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.moneyTextField.text = @"";
        return;
    }
    if([self.moneyTextField.text intValue] > 2000000){
        [SVProgressHUD showInfoWithStatus:@"存款金额太大"];
        [SVProgressHUD dismissWithDelay:0.5];
        self.moneyTextField.text = @"";
        return;
    }
    
    button.enabled = NO;
    
    NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
    dicInfo[@"name"] = self.nameTextField.text;
    dicInfo[@"account"] = [SZUser shareUser].readUser.userName;
    dicInfo[@"amount"] = self.moneyTextField.text;
    dicInfo[@"ctime"] = [GTool GetCurrentDateTime];
    dicInfo[@"type"] = self.type;
    dicInfo[@"caijin"] = @"1";
    [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kBankPay RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
        if([responseObject[@"status"] isEqualToString:@"success"]){
            if (self.clikeNextCall) {
                self.clikeNextCall([NSString stringWithFormat:@"%@",responseObject[@"ref_id"]],self.moneyTextField.text);
            }
            self.nameTextField.text = @"";
            self.moneyTextField.text = @"";
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"msg"]];
        }
        button.enabled = YES;
    } failure:^(NSError *error) {
        button.enabled = YES;
        [SVProgressHUD showErrorWithStatus:kNetError];
    }];
}

@end
