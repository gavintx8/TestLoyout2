//
//  GPaySuccessVc.m
//  QuCai
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GPaySuccessVc.h"

@interface GPaySuccessVc ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *orderDidTimeLabel;

@property(nonatomic,strong)NSTimer *countDownTimer;

@property(nonatomic,assign)NSInteger secondsCountDown;

@end

@implementation GPaySuccessVc

//static NSInteger  secondsCountDown = 86400;

- (void) onCreate {
    
    self.secondsCountDown = 86400;
    
    [self setupNav];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    
    _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];

    [self buildView:self.view];

    [self countDownTimer];
}

- (void)setupNav {
    self.navigationController.navigationBar.hidden = NO;
    self.view.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    self.navigationItem.title = @"网银转账";
}

- (void) onWillShow {
    
}

- (void) onDidAppear{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)buildView:(UIView *)view{
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(60);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    self.contentView = [[UIView alloc] init];
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.mas_offset(780);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"网银转账(元)"];
    [titleLabel setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    [moneyLabel setText:self.amount];
    [moneyLabel setTextColor:Title_Red];
    [moneyLabel setFont:[UIFont boldSystemFontOfSize:20.f]];
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(30);
    }];

    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.contentView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLabel.mas_bottom).offset(30);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    UIView *cardView = [[UIView alloc] init];
    cardView.backgroundColor = [UIColor colorWithRed:197.0/255 green:166.0/255 blue:119.0/255 alpha:1];
    [self.contentView addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(30);
        make.leading.equalTo(self.contentView).offset(20);
        make.trailing.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(180);
    }];
    [cardView.layer setCornerRadius:8];
    cardView.layer.masksToBounds = YES;
    
    UILabel *titleLabel2 = [[UILabel alloc] init];
    [titleLabel2 setText:@"请联系在线客服!!!"];
    [titleLabel2 setTextColor:[UIColor whiteColor]];
    [titleLabel2 setFont:[UIFont systemFontOfSize:18.f]];
    [cardView addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView).offset(20);
        make.left.equalTo(cardView).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *titleLabel3 = [[UILabel alloc] init];
    [titleLabel3 setText:@"    8888    8888    8888    8888    888"];
    [titleLabel3 setTextColor:[UIColor whiteColor]];
    [titleLabel3 setBackgroundColor:[UIColor colorWithRed:175.0/255 green:141.0/255 blue:93.0/255 alpha:1]];
    [titleLabel3 setFont:[UIFont systemFontOfSize:16.f]];
    [cardView addSubview:titleLabel3];
    [titleLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel2.mas_bottom);
        make.left.right.equalTo(cardView);
        make.height.mas_equalTo(40);
    }];
    
    UILabel *titleLabel4 = [[UILabel alloc] init];
    [titleLabel4 setText:@"开户名：请联系在线客服!!!"];
    [titleLabel4 setTextColor:[UIColor whiteColor]];
    [titleLabel4 setFont:[UIFont systemFontOfSize:14.f]];
    [cardView addSubview:titleLabel4];
    [titleLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel3.mas_bottom).offset(10);
        make.left.equalTo(cardView).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *titleLabel5 = [[UILabel alloc] init];
    [titleLabel5 setText:@"开户行：请联系在线客服!!!"];
    [titleLabel5 setTextColor:[UIColor whiteColor]];
    [titleLabel5 setFont:[UIFont systemFontOfSize:14.f]];
    [cardView addSubview:titleLabel5];
    [titleLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel4.mas_bottom).offset(10);
        make.left.equalTo(cardView).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *titleLabel6 = [[UILabel alloc] init];
    [titleLabel6 setText:@"备注"];
    [titleLabel6 setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [titleLabel6 setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:titleLabel6];
    [titleLabel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView.mas_bottom).offset(15);
        make.left.equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *remarkNumberLabel = [[UILabel alloc] init];
    [remarkNumberLabel setText:self.ref_id];
    [remarkNumberLabel setTextColor:[UIColor blackColor]];
    [remarkNumberLabel setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:remarkNumberLabel];
    [remarkNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardView.mas_bottom).offset(10);
        make.centerY.equalTo(titleLabel6);
        make.left.equalTo(titleLabel6.mas_right).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    if(self.bankDict != nil){
        titleLabel2.text = [NSString stringWithFormat:@"%@",[self.bankDict objectForKey:@"bankname"]];
        titleLabel3.text = [NSString stringWithFormat:@"    %@",[GTool bankCardFormat:[self.bankDict objectForKey:@"cardno"]]];
        titleLabel4.text = [NSString stringWithFormat:@"开户名：%@",[self.bankDict objectForKey:@"realname"]];
        titleLabel5.text = [NSString stringWithFormat:@"开户行：%@",[self.bankDict objectForKey:@"bankaddress"]];
        
        UIButton *copyButton1 = [self createButtonTag:@"" and:101];
        [copyButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.contentView addSubview:copyButton1];
        [copyButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.centerY.equalTo(titleLabel3);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        UIButton *copyButton2 = [self createButtonTag:@"" and:102];
        [self.contentView addSubview:copyButton2];
        [copyButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel4.mas_right).offset(20);
            make.centerY.equalTo(titleLabel4);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        UIButton *copyButton3 = [self createButtonTag:@"" and:103];
        [self.contentView addSubview:copyButton3];
        [copyButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel5.mas_right).offset(20);
            make.centerY.equalTo(titleLabel5);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
        
        UIButton *copyButton4 = [self createButtonTag:@"" and:104];
        [self.contentView addSubview:copyButton4];
        [copyButton4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(remarkNumberLabel.mas_right).offset(20);
            make.centerY.equalTo(remarkNumberLabel);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
    }
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel6.mas_bottom).offset(20);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *titleLabel7 = [[UILabel alloc] init];
    [titleLabel7 setText:@"下单时间"];
    [titleLabel7 setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [titleLabel7 setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:titleLabel7];
    [titleLabel7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.left.equalTo(self.contentView).offset(30);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *orderTimeLabel = [[UILabel alloc] init];
    [orderTimeLabel setText:[GTool GetCurrentDateTime]];
    [orderTimeLabel setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [orderTimeLabel setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:orderTimeLabel];
    [orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom);
        make.trailing.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.contentView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel7.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel8 = [[UILabel alloc] init];
    [titleLabel8 setText:@"订单编号"];
    [titleLabel8 setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [titleLabel8 setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:titleLabel8];
    [titleLabel8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.left.equalTo(self.contentView).offset(30);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *orderNumberLabel = [[UILabel alloc] init];
    [orderNumberLabel setText:self.ref_id];
    [orderNumberLabel setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [orderNumberLabel setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:orderNumberLabel];
    [orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3.mas_bottom);
        make.trailing.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line4 = [[UIView alloc] init];
    line4.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.contentView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel8.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *titleLabel9 = [[UILabel alloc] init];
    [titleLabel9 setText:@"订单失效时间"];
    [titleLabel9 setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [titleLabel9 setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:titleLabel9];
    [titleLabel9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom);
        make.left.equalTo(self.contentView).offset(30);
        make.height.mas_equalTo(45);
    }];
    
    self.orderDidTimeLabel = [[UILabel alloc] init];
    [self.orderDidTimeLabel setTextColor:[UIColor colorWithRed:169.0/255 green:141.0/255 blue:102.0/255 alpha:1]];
    [self.orderDidTimeLabel setFont:[UIFont systemFontOfSize:16.f]];
    [self.contentView addSubview:self.orderDidTimeLabel];
    [self.orderDidTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4.mas_bottom);
        make.trailing.equalTo(self.contentView).offset(-20);
        make.height.mas_equalTo(45);
    }];
    
    UIView *line5 = [[UIView alloc] init];
    line5.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.contentView addSubview:line5];
    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel9.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line5.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(260);
    }];
    
    UIButton *finishButton = [[UIButton alloc] init];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton setBackgroundColor:[UIColor colorWithRed:202.0/255 green:25.0/255 blue:30.0/255 alpha:1]];
    finishButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [finishButton setTitle:@"完成存款" forState:UIControlStateNormal];
    [finishButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [bottomView addSubview:finishButton];
    [finishButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomView).offset(10);
        make.centerX.equalTo(bottomView);
        make.leading.equalTo(bottomView).offset(40);
        make.trailing.equalTo(bottomView).offset(-40);
        make.height.mas_equalTo(42);
    }];
    [finishButton.layer setCornerRadius:3];
    finishButton.layer.masksToBounds = YES;
    [finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *cancelOrderButton = [[UIButton alloc] init];
    [cancelOrderButton setTitleColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1] forState:UIControlStateNormal];
    [cancelOrderButton setBackgroundColor:[UIColor colorWithRed:214.0/255 green:209.0/255 blue:203.0/255 alpha:1]];
    cancelOrderButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [cancelOrderButton setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancelOrderButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [bottomView addSubview:cancelOrderButton];
    [cancelOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(finishButton.mas_bottom).offset(20);
        make.centerX.equalTo(bottomView);
        make.leading.equalTo(bottomView).offset(40);
        make.trailing.equalTo(bottomView).offset(-40);
        make.height.mas_equalTo(42);
    }];
    [cancelOrderButton.layer setCornerRadius:3];
    cancelOrderButton.layer.masksToBounds = YES;
    [cancelOrderButton addTarget:self action:@selector(cancelOrderButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel10 = [[UILabel alloc] init];
    [titleLabel10 setText:@"温馨提示"];
    [titleLabel10 setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [titleLabel10 setFont:[UIFont systemFontOfSize:12.f]];
    [bottomView addSubview:titleLabel10];
    [titleLabel10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cancelOrderButton.mas_bottom).offset(20);
        make.left.equalTo(bottomView).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *titleLabel11 = [[UILabel alloc] init];
    [titleLabel11 setText:@"1.请注意『备注』中填写订单编号。若没有备注，将影响您的到帐时间。"];
    titleLabel11.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel11.numberOfLines = 0;
    [titleLabel11 setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [titleLabel11 setFont:[UIFont systemFontOfSize:12.f]];
    [bottomView addSubview:titleLabel11];
    [titleLabel11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel10.mas_bottom).offset(10);
        make.left.equalTo(bottomView).offset(10);
        make.trailing.equalTo(bottomView).offset(-20);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *titleLabel12 = [[UILabel alloc] init];
    [titleLabel12 setText:@"2.以上银行帐号限本次存款使用，帐号不定期更换！每次存款前请依照本页所显示的银行帐号入款。如入款至已过期帐号，公司无法查收，恕不负责！"];
    titleLabel12.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel12.numberOfLines = 0;
    [titleLabel12 setTextColor:[UIColor colorWithRed:130.0/255 green:130.0/255 blue:130.0/255 alpha:1]];
    [titleLabel12 setFont:[UIFont systemFontOfSize:12.f]];
    [bottomView addSubview:titleLabel12];
    [titleLabel12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel11.mas_bottom);
        make.left.equalTo(bottomView).offset(10);
        make.trailing.equalTo(bottomView).offset(-20);
        make.height.mas_equalTo(50);
    }];
}

-(void)countDownAction{
    self.secondsCountDown--;
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(self.secondsCountDown%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",self.secondsCountDown%60];
    NSString *format_time = [NSString stringWithFormat:@"%@ 分 %@ 秒",str_minute,str_second];
    self.orderDidTimeLabel.text = [NSString stringWithFormat:@"%@",format_time];
    if(self.secondsCountDown==0){
        [_countDownTimer invalidate];
    }
}

- (void)finishButtonClick:(UIButton *)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"提交成功,系统审核通过后，将会及时到账，请确保您的通讯畅通，以便客服与您联系。" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)cancelOrderButtonClick:(UIButton *)button{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"系统提示" message:@"您是否确定取消订单?若己完成支付,取消订单将会造成资金无法入账" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (UIButton *)createButtonTag:(NSString *)title and:(NSInteger)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"可复制" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:211.0/255 green:186.0/255 blue:149.0/255 alpha:1] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [btn setTag:tag];
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(copyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)copyButtonClick:(UIButton *)button{
    if (button.tag == 101) {
        [[UIPasteboard generalPasteboard] setString:[NSString stringWithFormat:@"%@",[self.bankDict objectForKey:@"cardno"]]];
    }else if(button.tag == 102){
        [[UIPasteboard generalPasteboard] setString:[NSString stringWithFormat:@"%@",[self.bankDict objectForKey:@"realname"]]];
    }else if(button.tag == 103){
        [[UIPasteboard generalPasteboard] setString:[NSString stringWithFormat:@"%@",[self.bankDict objectForKey:@"bankaddress"]]];
    }else if(button.tag == 104){
        [[UIPasteboard generalPasteboard] setString:self.ref_id];
    }
    [SVProgressHUD showInfoWithStatus:@"复制成功！"];
}

@end
