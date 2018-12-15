//
//  GFooterReusableView.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GFooterWyView.h"

@interface GFooterWyView ()

@property (nonatomic, assign) BOOL isQuotaSelect;
@property (nonatomic, strong) UITextField *moneyTextField;
@property (nonatomic, strong) UILabel *quotaLabel;
@property (nonatomic, strong) NSString *minquota;
@property (nonatomic, strong) NSString *maxquota;
@property (nonatomic, strong) NSString *payid;
@property (nonatomic, strong) NSString *paymentName;
@property (nonatomic, strong) NSString *bankcode;
@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) UIView *payView;
@property (nonatomic, strong) UIButton *btnPay1;
@property (nonatomic, strong) UIButton *btnPay2;
@property (nonatomic, strong) UIButton *btnPay3;
@property (nonatomic, strong) UIButton *btnPay4;
@property (nonatomic, strong) UIButton *btnPay5;
@property (nonatomic, strong) UIButton *btnPay6;
@property (nonatomic, strong) UIButton *btnPay7;
@property (nonatomic, strong) UIButton *btnPay8;
@property (nonatomic, strong) UIButton *btnPay9;
@property (nonatomic, strong) UIButton *btnPay10;
@property (nonatomic, strong) UIButton *btnPay11;
@property (nonatomic, strong) UIButton *btnPay12;
@property (nonatomic, strong) UIButton *btnPay13;
@property (nonatomic, strong) UIButton *btnPay14;
@property (nonatomic, strong) UIButton *btnPay15;
@property (nonatomic, strong) UIButton *btnPay16;
@property (nonatomic, strong) UIButton *btnPay17;
@property (nonatomic, strong) UIButton *btnPay18;
@property (nonatomic, strong) UIButton *btnPay19;
@property (nonatomic, strong) UIButton *btnPay20;
@property (nonatomic, strong) UIButton *btnPay21;

@property (nonatomic, strong) UIView *viewMQZF;
@property (nonatomic, strong) UIView *viewWT;
@property (nonatomic, strong) UIView *viewYFZF;
@property (nonatomic, strong) UIView *viewKJF;
@property (nonatomic, strong) UIView *viewXINFA;
@property (nonatomic, strong) UIView *viewOther;
@property (nonatomic, strong) UIView *lineMoney;
@property (nonatomic, strong) UIView *viewBGOne;

@end

@implementation GFooterWyView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.isQuotaSelect = YES;
        self.bankcode = @"";
        [self createUI];
    }
    return self;
}

- (void)updateTypeList:(NSArray *)typeList and:(NSString *)type and:(NSString *)cate{
    if (typeList.count > 0) {
        self.typeList = typeList;
        self.type = type;
        NSDictionary *dict = self.typeList[0];
        self.payid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
        self.minquota = [NSString stringWithFormat:@"%@",[dict objectForKey:@"minquota"]];
        self.maxquota = [NSString stringWithFormat:@"%@",[dict objectForKey:@"maxquota"]];
        [GTool setAttributeStringForPriceLabel:self.quotaLabel text:[NSString stringWithFormat:@"单笔限额(元)%d - %d",[self.minquota intValue],[self.maxquota intValue]]];
        
        if(self.typeList.count == 21){
            self.btnPay21.hidden = NO;
            self.btnPay20.hidden = NO;
            self.btnPay19.hidden = NO;
            self.btnPay18.hidden = NO;
            self.btnPay17.hidden = NO;
            self.btnPay16.hidden = NO;
            self.btnPay15.hidden = NO;
            self.btnPay14.hidden = NO;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(300);
            }];
        }
        if(self.typeList.count == 20){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = NO;
            self.btnPay19.hidden = NO;
            self.btnPay18.hidden = NO;
            self.btnPay17.hidden = NO;
            self.btnPay16.hidden = NO;
            self.btnPay15.hidden = NO;
            self.btnPay14.hidden = NO;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(300);
            }];
        }
        if(self.typeList.count == 19){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = NO;
            self.btnPay18.hidden = NO;
            self.btnPay17.hidden = NO;
            self.btnPay16.hidden = NO;
            self.btnPay15.hidden = NO;
            self.btnPay14.hidden = NO;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(300);
            }];
        }
        if(self.typeList.count == 18){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = NO;
            self.btnPay17.hidden = NO;
            self.btnPay16.hidden = NO;
            self.btnPay15.hidden = NO;
            self.btnPay14.hidden = NO;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(260);
            }];
        }
        if(self.typeList.count == 17){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = NO;
            self.btnPay16.hidden = NO;
            self.btnPay15.hidden = NO;
            self.btnPay14.hidden = NO;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(260);
            }];
        }
        if(self.typeList.count == 16){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = NO;
            self.btnPay15.hidden = NO;
            self.btnPay14.hidden = NO;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(260);
            }];
        }
        if(self.typeList.count == 15){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = NO;
            self.btnPay14.hidden = NO;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(220);
            }];
        }
        if(self.typeList.count == 14){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = NO;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(220);
            }];
        }
        if(self.typeList.count == 13){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = NO;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(220);
            }];
        }
        if(self.typeList.count == 12){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = NO;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(180);
            }];
        }
        if(self.typeList.count == 11){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = NO;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(180);
            }];
        }
        if(self.typeList.count == 10){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = NO;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(180);
            }];
        }
        if(self.typeList.count == 9){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = NO;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(140);
            }];
        }
        if(self.typeList.count == 8){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = YES;
            self.btnPay8.hidden = NO;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(140);
            }];
        }
        if(self.typeList.count == 7){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = YES;
            self.btnPay8.hidden = YES;
            self.btnPay7.hidden = NO;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(140);
            }];
        }
        if(self.typeList.count == 6){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = YES;
            self.btnPay8.hidden = YES;
            self.btnPay7.hidden = YES;
            self.btnPay6.hidden = NO;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(100);
            }];
        }
        if(self.typeList.count == 5){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = YES;
            self.btnPay8.hidden = YES;
            self.btnPay7.hidden = YES;
            self.btnPay6.hidden = YES;
            self.btnPay5.hidden = NO;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(100);
            }];
        }
        if(self.typeList.count == 4){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = YES;
            self.btnPay8.hidden = YES;
            self.btnPay7.hidden = YES;
            self.btnPay6.hidden = YES;
            self.btnPay5.hidden = YES;
            self.btnPay4.hidden = NO;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(100);
            }];
        }
        if(self.typeList.count == 3){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = YES;
            self.btnPay8.hidden = YES;
            self.btnPay7.hidden = YES;
            self.btnPay6.hidden = YES;
            self.btnPay5.hidden = YES;
            self.btnPay4.hidden = YES;
            self.btnPay3.hidden = NO;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(60);
            }];
        }
        if(self.typeList.count == 2){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = YES;
            self.btnPay8.hidden = YES;
            self.btnPay7.hidden = YES;
            self.btnPay6.hidden = YES;
            self.btnPay5.hidden = YES;
            self.btnPay4.hidden = YES;
            self.btnPay3.hidden = YES;
            self.btnPay2.hidden = NO;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(60);
            }];
        }
        if(self.typeList.count == 1){
            self.btnPay21.hidden = YES;
            self.btnPay20.hidden = YES;
            self.btnPay19.hidden = YES;
            self.btnPay18.hidden = YES;
            self.btnPay17.hidden = YES;
            self.btnPay16.hidden = YES;
            self.btnPay15.hidden = YES;
            self.btnPay14.hidden = YES;
            self.btnPay13.hidden = YES;
            self.btnPay12.hidden = YES;
            self.btnPay11.hidden = YES;
            self.btnPay10.hidden = YES;
            self.btnPay9.hidden = YES;
            self.btnPay8.hidden = YES;
            self.btnPay7.hidden = YES;
            self.btnPay6.hidden = YES;
            self.btnPay5.hidden = YES;
            self.btnPay4.hidden = YES;
            self.btnPay3.hidden = YES;
            self.btnPay2.hidden = YES;
            self.btnPay1.hidden = NO;
            [self.payView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(60);
            }];
        }
        UIView *bankView = [self viewWithTag:10001];
        if ([cate isEqualToString:@"WYZF"]) {
            bankView.hidden = NO;
            [bankView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(55);
            }];
        }else{
            bankView.hidden = YES;
            [bankView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0);
            }];
        }
        
        NSInteger indextype = 0;
        if(self.payNumber + 1 >= self.typeList.count){
            indextype = 0;
        }else{
            indextype = self.payNumber;
        }
        NSDictionary *dictType = self.typeList[indextype];
        self.payid = [NSString stringWithFormat:@"%@",[dictType objectForKey:@"id"]];
        self.paymentName = [NSString stringWithFormat:@"%@",[dictType objectForKey:@"paymentName"]];
        self.minquota = [NSString stringWithFormat:@"%@",[dictType objectForKey:@"minquota"]];
        self.maxquota = [NSString stringWithFormat:@"%@",[dictType objectForKey:@"maxquota"]];
        if([self.paymentName isEqualToString:@"MQZF"]){
            self.viewMQZF.hidden = NO;
            self.viewWT.hidden = YES;
            self.viewYFZF.hidden = YES;
            self.viewKJF.hidden = YES;
            self.viewOther.hidden = YES;
            self.viewBGOne.hidden = YES;
            self.lineMoney.hidden = YES;
            self.viewXINFA.hidden = YES;
        }else if([self.paymentName isEqualToString:@"WT"]){
            self.viewMQZF.hidden = YES;
            self.viewYFZF.hidden = YES;
            self.viewWT.hidden = NO;
            self.viewKJF.hidden = YES;
            self.viewOther.hidden = YES;
            self.viewBGOne.hidden = YES;
            self.lineMoney.hidden = YES;
            self.viewXINFA.hidden = YES;
        }else if([self.paymentName isEqualToString:@"YFZF"]){
            self.viewMQZF.hidden = YES;
            self.viewWT.hidden = YES;
            self.viewYFZF.hidden = NO;
            self.viewKJF.hidden = YES;
            self.viewOther.hidden = YES;
            self.viewBGOne.hidden = YES;
            self.lineMoney.hidden = YES;
            self.viewXINFA.hidden = YES;
        }else if([self.paymentName isEqualToString:@"KJFtemp"]){
            self.viewMQZF.hidden = YES;
            self.viewWT.hidden = YES;
            self.viewYFZF.hidden = YES;
            self.viewKJF.hidden = NO;
            self.viewOther.hidden = YES;
            self.viewBGOne.hidden = YES;
            self.lineMoney.hidden = YES;
            self.viewXINFA.hidden = YES;
        }else if([self.paymentName isEqualToString:@"XINFA"]  && [type isEqualToString:@"wx"]){
            self.viewMQZF.hidden = YES;
            self.viewWT.hidden = YES;
            self.viewYFZF.hidden = YES;
            self.viewKJF.hidden = YES;
            self.viewOther.hidden = YES;
            self.viewBGOne.hidden = YES;
            self.lineMoney.hidden = YES;
            self.viewXINFA.hidden = NO;
        }else{
            self.viewMQZF.hidden = YES;
            self.viewWT.hidden = YES;
            self.viewYFZF.hidden = YES;
            self.viewKJF.hidden = YES;
            self.viewOther.hidden = NO;
            self.viewBGOne.hidden = NO;
            self.lineMoney.hidden = NO;
            self.viewXINFA.hidden = YES;
        }
    }
}

#pragma mark - Setter Getter Methods

- (void)createUI{
    
    UIView *bgView = [[UIView alloc] init];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(5);
        make.left.bottom.right.mas_equalTo(self);
    }];
    
    [self buildPayView:bgView];
    [self buildMoneyView:bgView];
    [self buildBankList:bgView];
    [self buildBottomView:bgView];
}

- (void)buildPayView:(UIView *)bgView{
    
    self.payView = [[UIView alloc] init];
    [self.payView setTag:100];
    [bgView addSubview:self.payView];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bgView);
        make.height.mas_equalTo(100);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.payView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.payView);
        make.height.mas_equalTo(10);
    }];
    
    self.btnPay1 = [self createButtonTag:@"支付1" and:101];
    [self.payView addSubview:self.btnPay1];
    [self.btnPay1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payView).offset(20);
        make.leading.equalTo(self.payView).offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    self.payNumber = GPayNumber1;
    [self.btnPay1 setImage:[UIImage imageNamed:@"icon_reddot"] forState:UIControlStateNormal];
    [GTool dc_chageControlCircularWith:self.btnPay1 AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:BG_Nav canMasksToBounds:YES];
    
    self.btnPay2 = [self createButtonTag:@"支付2" and:102];
    [self.payView addSubview:self.btnPay2];
    [self.btnPay2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payView).offset(20);
        make.centerX.equalTo(self.payView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay3 = [self createButtonTag:@"支付3" and:103];
    [self.payView addSubview:self.btnPay3];
    [self.btnPay3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payView).offset(20);
        make.trailing.equalTo(self.payView).offset(-25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay4 = [self createButtonTag:@"支付4" and:104];
    [self.payView addSubview:self.btnPay4];
    [self.btnPay4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay1.mas_bottom).offset(10);
        make.leading.equalTo(self.payView).offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay5 = [self createButtonTag:@"支付5" and:105];
    [self.payView addSubview:self.btnPay5];
    [self.btnPay5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay1.mas_bottom).offset(10);
        make.centerX.equalTo(self.payView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay6 = [self createButtonTag:@"支付6" and:106];
    [self.payView addSubview:self.btnPay6];
    [self.btnPay6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay1.mas_bottom).offset(10);
        make.trailing.equalTo(self.payView).offset(-25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay7 = [self createButtonTag:@"支付7" and:107];
    [self.payView addSubview:self.btnPay7];
    [self.btnPay7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay4.mas_bottom).offset(10);
        make.leading.equalTo(self.payView).offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay8 = [self createButtonTag:@"支付8" and:108];
    [self.payView addSubview:self.btnPay8];
    [self.btnPay8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay4.mas_bottom).offset(10);
        make.centerX.equalTo(self.payView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay9 = [self createButtonTag:@"支付9" and:109];
    [self.payView addSubview:self.btnPay9];
    [self.btnPay9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay4.mas_bottom).offset(10);
        make.trailing.equalTo(self.payView).offset(-25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay10 = [self createButtonTag:@"支付7" and:110];
    [self.payView addSubview:self.btnPay10];
    [self.btnPay10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay7.mas_bottom).offset(10);
        make.leading.equalTo(self.payView).offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay11 = [self createButtonTag:@"支付8" and:111];
    [self.payView addSubview:self.btnPay11];
    [self.btnPay11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay7.mas_bottom).offset(10);
        make.centerX.equalTo(self.payView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay12 = [self createButtonTag:@"支付9" and:112];
    [self.payView addSubview:self.btnPay12];
    [self.btnPay12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay7.mas_bottom).offset(10);
        make.trailing.equalTo(self.payView).offset(-25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay13 = [self createButtonTag:@"支付13" and:110];
    [self.payView addSubview:self.btnPay13];
    [self.btnPay13 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay10.mas_bottom).offset(10);
        make.leading.equalTo(self.payView).offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay14 = [self createButtonTag:@"支付14" and:111];
    [self.payView addSubview:self.btnPay14];
    [self.btnPay14 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay10.mas_bottom).offset(10);
        make.centerX.equalTo(self.payView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay15 = [self createButtonTag:@"支付15" and:112];
    [self.payView addSubview:self.btnPay15];
    [self.btnPay15 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay10.mas_bottom).offset(10);
        make.trailing.equalTo(self.payView).offset(-25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay16 = [self createButtonTag:@"支付13" and:116];
    [self.payView addSubview:self.btnPay16];
    [self.btnPay16 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay13.mas_bottom).offset(10);
        make.leading.equalTo(self.payView).offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay17 = [self createButtonTag:@"支付14" and:117];
    [self.payView addSubview:self.btnPay17];
    [self.btnPay17 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay13.mas_bottom).offset(10);
        make.centerX.equalTo(self.payView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay18 = [self createButtonTag:@"支付15" and:118];
    [self.payView addSubview:self.btnPay18];
    [self.btnPay18 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay13.mas_bottom).offset(10);
        make.trailing.equalTo(self.payView).offset(-25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay19 = [self createButtonTag:@"支付19" and:116];
    [self.payView addSubview:self.btnPay19];
    [self.btnPay19 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay16.mas_bottom).offset(10);
        make.leading.equalTo(self.payView).offset(25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay20 = [self createButtonTag:@"支付20" and:117];
    [self.payView addSubview:self.btnPay20];
    [self.btnPay20 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay16.mas_bottom).offset(10);
        make.centerX.equalTo(self.payView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.btnPay21 = [self createButtonTag:@"支付21" and:118];
    [self.payView addSubview:self.btnPay21];
    [self.btnPay21 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnPay16.mas_bottom).offset(10);
        make.trailing.equalTo(self.payView).offset(-25);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.payView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.payView);
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
    [GTool dc_chageControlCircularWith:btn AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:[UIColor colorWithRed:223.0/255 green:225.0/255 blue:232.0/255 alpha:1] canMasksToBounds:YES];
    [btn addTarget:self action:@selector(payButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGRect titleFrame = btn.titleLabel.frame;
    CGRect imageFrame = btn.imageView.frame;
    CGFloat space = titleFrame.origin.x - imageFrame.origin.x - imageFrame.size.width + 5;
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0,titleFrame.size.width + space, 0, -(titleFrame.size.width + space))];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, titleFrame.origin.x - imageFrame.origin.x)];
    [btn setImage:[UIImage imageNamed:@"icon_reddot-n"] forState:UIControlStateNormal];
    
    return btn;
}

- (void)payButtonClick:(UIButton *)button{
    for (int i = 101; i < 122; i++) {
        if (button.tag == i) {
            [button setImage:[UIImage imageNamed:@"icon_reddot"] forState:UIControlStateNormal];
            [GTool dc_chageControlCircularWith:button AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:BG_Nav canMasksToBounds:YES];
        }else{
            UIButton *myButton = [self viewWithTag:i];
            [myButton setImage:[UIImage imageNamed:@"icon_reddot-n"] forState:UIControlStateNormal];
            [GTool dc_chageControlCircularWith:myButton AndSetCornerRadius:3 SetBorderWidth:1 SetBorderColor:[UIColor colorWithRed:223.0/255 green:225.0/255 blue:232.0/255 alpha:1] canMasksToBounds:YES];
        }
    }
    
    switch (button.tag) {
        case 101:{
            self.payNumber = GPayNumber1;
        }
            break;
        case 102:{
            self.payNumber = GPayNumber2;
        }
            break;
        case 103:{
            self.payNumber = GPayNumber3;
        }
            break;
        case 104:{
            self.payNumber = GPayNumber4;
        }
            break;
        case 105:{
            self.payNumber = GPayNumber5;
        }
            break;
        case 106:{
            self.payNumber = GPayNumber6;
        }
            break;
        case 107:{
            self.payNumber = GPayNumber7;
        }
            break;
        case 108:{
            self.payNumber = GPayNumber8;
        }
            break;
        case 109:{
            self.payNumber = GPayNumber9;
        }
            break;
        case 110:{
            self.payNumber = GPayNumber10;
        }
            break;
        case 111:{
            self.payNumber = GPayNumber11;
        }
            break;
        case 112:{
            self.payNumber = GPayNumber12;
        }
            break;
        case 113:{
            self.payNumber = GPayNumber13;
        }
            break;
        case 114:{
            self.payNumber = GPayNumber14;
        }
            break;
        case 115:{
            self.payNumber = GPayNumber15;
        }
            break;
        case 116:{
            self.payNumber = GPayNumber16;
        }
            break;
        case 117:{
            self.payNumber = GPayNumber17;
        }
            break;
        case 118:{
            self.payNumber = GPayNumber18;
        }
            break;
        case 119:{
            self.payNumber = GPayNumber19;
        }
            break;
        case 120:{
            self.payNumber = GPayNumber20;
        }
            break;
        case 121:{
            self.payNumber = GPayNumber21;
        }
            break;
    }
    NSInteger typeIndex = button.tag - 101;
    NSDictionary *dict = self.typeList[typeIndex];
    self.payid = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    self.paymentName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"paymentName"]];
    self.minquota = [NSString stringWithFormat:@"%@",[dict objectForKey:@"minquota"]];
    self.maxquota = [NSString stringWithFormat:@"%@",[dict objectForKey:@"maxquota"]];
    [GTool setAttributeStringForPriceLabel:self.quotaLabel text:[NSString stringWithFormat:@"单笔限额(元)%d - %d",[self.minquota intValue],[self.maxquota intValue]]];
    
    if([self.paymentName isEqualToString:@"MQZF"]){
        self.viewMQZF.hidden = NO;
        self.viewWT.hidden = YES;
        self.viewYFZF.hidden = YES;
        self.viewKJF.hidden = YES;
        self.viewOther.hidden = YES;
        self.viewBGOne.hidden = YES;
        self.lineMoney.hidden = YES;
        self.viewXINFA.hidden = YES;
    }else if([self.paymentName isEqualToString:@"WT"]){
        self.viewMQZF.hidden = YES;
        self.viewYFZF.hidden = YES;
        self.viewWT.hidden = NO;
        self.viewKJF.hidden = YES;
        self.viewOther.hidden = YES;
        self.viewBGOne.hidden = YES;
        self.lineMoney.hidden = YES;
        self.viewXINFA.hidden = YES;
    }else if([self.paymentName isEqualToString:@"YFZF"]){
        self.viewMQZF.hidden = YES;
        self.viewWT.hidden = YES;
        self.viewYFZF.hidden = NO;
        self.viewKJF.hidden = YES;
        self.viewOther.hidden = YES;
        self.viewBGOne.hidden = YES;
        self.lineMoney.hidden = YES;
        self.viewXINFA.hidden = YES;
    }else if([self.paymentName isEqualToString:@"KJFtemp"]){
        self.viewMQZF.hidden = YES;
        self.viewWT.hidden = YES;
        self.viewYFZF.hidden = YES;
        self.viewKJF.hidden = NO;
        self.viewOther.hidden = YES;
        self.viewBGOne.hidden = YES;
        self.lineMoney.hidden = YES;
        self.viewXINFA.hidden = YES;
    }else if([self.paymentName isEqualToString:@"XINFA"] && [self.type isEqualToString:@"wx"]){
        self.viewMQZF.hidden = YES;
        self.viewWT.hidden = YES;
        self.viewYFZF.hidden = YES;
        self.viewKJF.hidden = NO;
        self.viewOther.hidden = YES;
        self.viewBGOne.hidden = YES;
        self.lineMoney.hidden = YES;
        self.viewXINFA.hidden = NO;
    }else{
        self.viewMQZF.hidden = YES;
        self.viewWT.hidden = YES;
        self.viewYFZF.hidden = YES;
        self.viewKJF.hidden = YES;
        self.viewOther.hidden = NO;
        self.viewBGOne.hidden = NO;
        self.lineMoney.hidden = NO;
        self.viewXINFA.hidden = YES;
    }
    self.moneyTextField.text = @"";
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
    
    self.viewBGOne = [[UIView alloc] init];
    [self.viewBGOne setTag:1002];
    [moneyView addSubview:self.viewBGOne];
    [self.viewBGOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [titleLabel setText:@"金额"];
    [titleLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.viewBGOne addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBGOne);
        make.left.equalTo(self.viewBGOne).offset(30);
        make.height.mas_equalTo(45);
    }];
    
    self.moneyTextField = [[UITextField alloc] init];
    [self.moneyTextField setFont:[UIFont systemFontOfSize:14.f]];
    [self.moneyTextField setTag:10111];
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.moneyTextField setPlaceholder:@"请输入金额"];
    [self.moneyTextField setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [self.viewBGOne addSubview:self.moneyTextField];
    [self.moneyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBGOne);
        make.left.equalTo(titleLabel.mas_right).offset(10);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(180);
    }];
    
    UIButton *quotaButton = [[UIButton alloc] init];
    [quotaButton setTitleColor:Title_Red forState:UIControlStateNormal];
    [quotaButton setTitle:@"限额说明" forState:UIControlStateNormal];
    quotaButton.titleLabel.font = [UIFont systemFontOfSize: 15.0];
    [quotaButton setTag:1234];
    [self.viewBGOne addSubview:quotaButton];
    [quotaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBGOne);
        make.right.equalTo(self.viewBGOne).offset(-20);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(80);
    }];
    [quotaButton addTarget:self action:@selector(quotaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineMoney = [[UIView alloc] init];
    self.lineMoney.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [moneyView addSubview:self.lineMoney];
    [self.lineMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView).offset(45);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(1);
    }];
    
    self.quotaLabel = [[UILabel alloc] init];
    [self.quotaLabel setBackgroundColor:[UIColor colorWithRed:221.0/255 green:222.0/255 blue:222.0/255 alpha:1]];
    [self.quotaLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.quotaLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    self.quotaLabel.textAlignment = NSTextAlignmentRight;
    [self.quotaLabel setTag:1003];
    [moneyView addSubview:self.quotaLabel];
    [self.quotaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBGOne.mas_bottom);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(0);
    }];
    
    //MQZF
    
    self.viewMQZF = [[UIView alloc] init];
    [self.viewMQZF setTag:1004];
    [moneyView addSubview:self.viewMQZF];
    [self.viewMQZF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(90);
    }];
    
    UIButton *moneyButtonMQZF1 = [self createButtonTag2:@"100" and:801];
    [self.viewMQZF addSubview:moneyButtonMQZF1];
    [moneyButtonMQZF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.leading.equalTo(self.viewMQZF).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF2 = [self createButtonTag2:@"200" and:802];
    [self.viewMQZF addSubview:moneyButtonMQZF2];
    [moneyButtonMQZF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonMQZF1.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF3 = [self createButtonTag2:@"500" and:803];
    [self.viewMQZF addSubview:moneyButtonMQZF3];
    [moneyButtonMQZF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonMQZF2.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF4 = [self createButtonTag2:@"800" and:804];
    [self.viewMQZF addSubview:moneyButtonMQZF4];
    [moneyButtonMQZF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonMQZF3.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF5 = [self createButtonTag2:@"1000" and:805];
    [self.viewMQZF addSubview:moneyButtonMQZF5];
    [moneyButtonMQZF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonMQZF4.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF6 = [self createButtonTag2:@"1200" and:806];
    [self.viewMQZF addSubview:moneyButtonMQZF6];
    [moneyButtonMQZF6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonMQZF5.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF7 = [self createButtonTag2:@"1500" and:807];
    [self.viewMQZF addSubview:moneyButtonMQZF7];
    [moneyButtonMQZF7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonMQZF6.mas_bottom).offset(7);
        make.leading.equalTo(self.viewMQZF).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF8 = [self createButtonTag2:@"1800" and:808];
    [self.viewMQZF addSubview:moneyButtonMQZF8];
    [moneyButtonMQZF8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonMQZF6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonMQZF7.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF9 = [self createButtonTag2:@"2000" and:809];
    [self.viewMQZF addSubview:moneyButtonMQZF9];
    [moneyButtonMQZF9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonMQZF6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonMQZF8.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF10 = [self createButtonTag2:@"3000" and:810];
    [self.viewMQZF addSubview:moneyButtonMQZF10];
    [moneyButtonMQZF10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonMQZF6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonMQZF9.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF11 = [self createButtonTag2:@"4000" and:811];
    [self.viewMQZF addSubview:moneyButtonMQZF11];
    [moneyButtonMQZF11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonMQZF6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonMQZF10.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonMQZF12 = [self createButtonTag2:@"5000" and:812];
    [self.viewMQZF addSubview:moneyButtonMQZF12];
    [moneyButtonMQZF12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonMQZF6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonMQZF11.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIView *lineMQZF2 = [[UIView alloc] init];
    lineMQZF2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.viewMQZF addSubview:lineMQZF2];
    [lineMQZF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.viewMQZF);
        make.height.mas_equalTo(1);
    }];
    
    //        [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.bottom.equalTo(viewMQZF.mas_bottom);
    //        }];
    
    //WT
    
    self.viewWT = [[UIView alloc] init];
    [self.viewWT setTag:1004];
    [moneyView addSubview:self.viewWT];
    [self.viewWT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(90);
    }];
    
    UIButton *moneyButtonWT1 = [self createButtonTag2:@"50" and:901];
    [self.viewWT addSubview:moneyButtonWT1];
    [moneyButtonWT1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewWT).offset(7);
        make.leading.equalTo(self.viewWT).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT2 = [self createButtonTag2:@"100" and:902];
    [self.viewWT addSubview:moneyButtonWT2];
    [moneyButtonWT2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewWT).offset(7);
        make.left.equalTo(moneyButtonWT1.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT3 = [self createButtonTag2:@"300" and:903];
    [self.viewWT addSubview:moneyButtonWT3];
    [moneyButtonWT3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewWT).offset(7);
        make.left.equalTo(moneyButtonWT2.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT4 = [self createButtonTag2:@"500" and:904];
    [self.viewWT addSubview:moneyButtonWT4];
    [moneyButtonWT4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewWT).offset(7);
        make.left.equalTo(moneyButtonWT3.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT5 = [self createButtonTag2:@"800" and:905];
    [self.viewWT addSubview:moneyButtonWT5];
    [moneyButtonWT5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewWT).offset(7);
        make.left.equalTo(moneyButtonWT4.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT6 = [self createButtonTag2:@"1000" and:906];
    [self.viewWT addSubview:moneyButtonWT6];
    [moneyButtonWT6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewWT).offset(7);
        make.left.equalTo(moneyButtonWT5.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT7 = [self createButtonTag2:@"1500" and:907];
    [self.viewWT addSubview:moneyButtonWT7];
    [moneyButtonWT7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonWT6.mas_bottom).offset(7);
        make.leading.equalTo(self.viewWT).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT8 = [self createButtonTag2:@"2100" and:908];
    [self.viewWT addSubview:moneyButtonWT8];
    [moneyButtonWT8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonWT6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonWT7.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT9 = [self createButtonTag2:@"2700" and:909];
    [self.viewWT addSubview:moneyButtonWT9];
    [moneyButtonWT9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonWT6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonWT8.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT10 = [self createButtonTag2:@"3000" and:910];
    [self.viewWT addSubview:moneyButtonWT10];
    [moneyButtonWT10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonWT6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonWT9.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT11 = [self createButtonTag2:@"5000" and:911];
    [self.viewWT addSubview:moneyButtonWT11];
    [moneyButtonWT11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonWT6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonWT10.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonWT12 = [self createButtonTag2:@"10000" and:912];
    [self.viewWT addSubview:moneyButtonWT12];
    [moneyButtonWT12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonWT6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonWT11.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIView *lineWT2 = [[UIView alloc] init];
    lineWT2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.viewWT addSubview:lineWT2];
    [lineWT2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.viewWT);
        make.height.mas_equalTo(1);
    }];
    
    //        [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.bottom.equalTo(viewWT.mas_bottom);
    //        }];
    
    //YFZF
    
    self.viewYFZF = [[UIView alloc] init];
    [self.viewYFZF setTag:1004];
    [moneyView addSubview:self.viewYFZF];
    [self.viewYFZF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(90);
    }];
    
    UIButton *moneyButtonYFZF1 = [self createButtonTag2:@"50" and:1101];
    [self.viewYFZF addSubview:moneyButtonYFZF1];
    [moneyButtonYFZF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.leading.equalTo(self.viewMQZF).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonYFZF2 = [self createButtonTag2:@"100" and:1102];
    [self.viewYFZF addSubview:moneyButtonYFZF2];
    [moneyButtonYFZF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonYFZF1.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonYFZF3 = [self createButtonTag2:@"200" and:1103];
    [self.viewYFZF addSubview:moneyButtonYFZF3];
    [moneyButtonYFZF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonYFZF2.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonYFZF4 = [self createButtonTag2:@"500" and:1104];
    [self.viewYFZF addSubview:moneyButtonYFZF4];
    [moneyButtonYFZF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonYFZF3.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonYFZF5 = [self createButtonTag2:@"1000" and:1105];
    [self.viewYFZF addSubview:moneyButtonYFZF5];
    [moneyButtonYFZF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonYFZF4.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonYFZF6 = [self createButtonTag2:@"2000" and:1106];
    [self.viewYFZF addSubview:moneyButtonYFZF6];
    [moneyButtonYFZF6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMQZF).offset(7);
        make.left.equalTo(moneyButtonYFZF5.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonYFZF7 = [self createButtonTag2:@"5000" and:1107];
    [self.viewYFZF addSubview:moneyButtonYFZF7];
    [moneyButtonYFZF7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonYFZF6.mas_bottom).offset(7);
        make.leading.equalTo(self.viewMQZF).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonYFZF8 = [self createButtonTag2:@"10000" and:1108];
    [self.viewYFZF addSubview:moneyButtonYFZF8];
    [moneyButtonYFZF8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonYFZF6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonYFZF7.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    //KJFtemp
    
    self.viewKJF = [[UIView alloc] init];
    [self.viewKJF setTag:1004];
    [moneyView addSubview:self.viewKJF];
    [self.viewKJF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(90);
    }];
    
    UIButton *moneyButtonKJF1 = [self createButtonTag2:@"50" and:1901];
    [self.viewKJF addSubview:moneyButtonKJF1];
    [moneyButtonKJF1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewKJF).offset(7);
        make.leading.equalTo(self.viewKJF).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonKJF2 = [self createButtonTag2:@"100" and:1902];
    [self.viewKJF addSubview:moneyButtonKJF2];
    [moneyButtonKJF2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewKJF).offset(7);
        make.left.equalTo(moneyButtonKJF1.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonKJF3 = [self createButtonTag2:@"200" and:1903];
    [self.viewKJF addSubview:moneyButtonKJF3];
    [moneyButtonKJF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewKJF).offset(7);
        make.left.equalTo(moneyButtonKJF2.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonKJF4 = [self createButtonTag2:@"300" and:1904];
    [self.viewKJF addSubview:moneyButtonKJF4];
    [moneyButtonKJF4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewKJF).offset(7);
        make.left.equalTo(moneyButtonKJF3.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonKJF5 = [self createButtonTag2:@"500" and:1905];
    [self.viewKJF addSubview:moneyButtonKJF5];
    [moneyButtonKJF5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewKJF).offset(7);
        make.left.equalTo(moneyButtonKJF4.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonKJF6 = [self createButtonTag2:@"1000" and:1906];
    [self.viewKJF addSubview:moneyButtonKJF6];
    [moneyButtonKJF6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewKJF).offset(7);
        make.left.equalTo(moneyButtonKJF5.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonKJF7 = [self createButtonTag2:@"2000" and:1907];
    [self.viewKJF addSubview:moneyButtonKJF7];
    [moneyButtonKJF7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonKJF6.mas_bottom).offset(7);
        make.leading.equalTo(self.viewKJF).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonKJF8 = [self createButtonTag2:@"3000" and:1908];
    [self.viewKJF addSubview:moneyButtonKJF8];
    [moneyButtonKJF8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonKJF6.mas_bottom).offset(7);
        make.left.equalTo(moneyButtonKJF7.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    //XINFA
    
    self.viewXINFA = [[UIView alloc] init];
    [self.viewXINFA setTag:1004];
    [moneyView addSubview:self.viewXINFA];
    [self.viewXINFA mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(90);
    }];
    
    UIButton *moneyButtonXINFA1 = [self createButtonTag2:@"20" and:2001];
    [self.viewXINFA addSubview:moneyButtonXINFA1];
    [moneyButtonXINFA1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewXINFA).offset(7);
        make.leading.equalTo(self.viewXINFA).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonXINFA2 = [self createButtonTag2:@"30" and:2002];
    [self.viewXINFA addSubview:moneyButtonXINFA2];
    [moneyButtonXINFA2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewXINFA).offset(7);
        make.left.equalTo(moneyButtonXINFA1.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonXINFA3 = [self createButtonTag2:@"50" and:2003];
    [self.viewXINFA addSubview:moneyButtonXINFA3];
    [moneyButtonXINFA3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewXINFA).offset(7);
        make.left.equalTo(moneyButtonXINFA2.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonXINFA4 = [self createButtonTag2:@"100" and:2004];
    [self.viewXINFA addSubview:moneyButtonXINFA4];
    [moneyButtonXINFA4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewXINFA).offset(7);
        make.left.equalTo(moneyButtonXINFA3.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonXINFA5 = [self createButtonTag2:@"200" and:2005];
    [self.viewXINFA addSubview:moneyButtonXINFA5];
    [moneyButtonXINFA5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewXINFA).offset(7);
        make.left.equalTo(moneyButtonXINFA4.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonXINFA6 = [self createButtonTag2:@"300" and:2006];
    [self.viewXINFA addSubview:moneyButtonXINFA6];
    [moneyButtonXINFA6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewXINFA).offset(7);
        make.left.equalTo(moneyButtonXINFA5.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonXINFA7 = [self createButtonTag2:@"500" and:2007];
    [self.viewXINFA addSubview:moneyButtonXINFA7];
    [moneyButtonXINFA7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyButtonXINFA6.mas_bottom).offset(7);
        make.leading.equalTo(self.viewXINFA).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    //Other
    
    self.viewOther = [[UIView alloc] init];
    [self.viewOther setTag:1004];
    [moneyView addSubview:self.viewOther];
    [self.viewOther mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.quotaLabel.mas_bottom);
        make.left.right.equalTo(moneyView);
        make.height.mas_equalTo(45);
    }];
    
    UIButton *moneyButtonOther1 = [self createButtonTag2:@"100" and:201];
    [self.viewOther addSubview:moneyButtonOther1];
    [moneyButtonOther1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewOther).offset(7);
        make.leading.equalTo(self.viewOther).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonOther2 = [self createButtonTag2:@"300" and:202];
    [self.viewOther addSubview:moneyButtonOther2];
    [moneyButtonOther2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewOther).offset(7);
        make.left.equalTo(moneyButtonOther1.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonOther3 = [self createButtonTag2:@"500" and:203];
    [self.viewOther addSubview:moneyButtonOther3];
    [moneyButtonOther3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewOther).offset(7);
        make.left.equalTo(moneyButtonOther2.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonOther4 = [self createButtonTag2:@"1000" and:204];
    [self.viewOther addSubview:moneyButtonOther4];
    [moneyButtonOther4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewOther).offset(7);
        make.left.equalTo(moneyButtonOther3.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *moneyButtonOther5 = [self createButtonTag2:@"1500" and:205];
    [self.viewOther addSubview:moneyButtonOther5];
    [moneyButtonOther5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewOther).offset(7);
        make.left.equalTo(moneyButtonOther4.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    UIView *lineOther2 = [[UIView alloc] init];
    lineOther2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [self.viewOther addSubview:lineOther2];
    [lineOther2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.viewOther);
        make.height.mas_equalTo(1);
    }];
    
    //        [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.bottom.equalTo(viewOther.mas_bottom);
    //        }];
}

- (void)quotaButtonClick:(UIButton *)button{
    
    
    UILabel *quotaLabel = [self viewWithTag:1003];
    UIView *moneyView = [self viewWithTag:1001];
    
    if (self.isQuotaSelect) {
        [quotaLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@45);
        }];
        [moneyView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@135);
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
    if([self.paymentName isEqualToString:@"MQZF"]){
        for (int i = 801; i < 813; i++) {
            if (button.tag == i) {
                [button setTitleColor:BG_Nav forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor colorWithRed:249.0/255 green:228.0/255 blue:228.0/255 alpha:1]];
            }else{
                UIButton *myButton = [self viewWithTag:i];
                [myButton setBackgroundColor:[UIColor whiteColor]];
                [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
            }
        }
        
        UITextField *text = [self viewWithTag:10111];
        switch (button.tag) {
            case 801:{
                [text setText:@"100"];
            }
                break;
            case 802:{
                [text setText:@"200"];
            }
                break;
            case 803:{
                [text setText:@"500"];
            }
                break;
            case 804:{
                [text setText:@"800"];
            }
                break;
            case 805:{
                [text setText:@"1000"];
            }
                break;
            case 806:{
                [text setText:@"1200"];
            }
                break;
            case 807:{
                [text setText:@"1500"];
            }
                break;
            case 808:{
                [text setText:@"1800"];
            }
                break;
            case 809:{
                [text setText:@"2000"];
            }
                break;
            case 810:{
                [text setText:@"3000"];
            }
                break;
            case 811:{
                [text setText:@"4000"];
            }
                break;
            case 812:{
                [text setText:@"5000"];
            }
                break;
        }
    }else if([self.paymentName isEqualToString:@"WT"]){
        for (int i = 901; i < 913; i++) {
            if (button.tag == i) {
                [button setTitleColor:BG_Nav forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor colorWithRed:249.0/255 green:228.0/255 blue:228.0/255 alpha:1]];
            }else{
                UIButton *myButton = [self viewWithTag:i];
                [myButton setBackgroundColor:[UIColor whiteColor]];
                [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
            }
        }
        
        UITextField *text = [self viewWithTag:10111];
        switch (button.tag) {
            case 901:{
                [text setText:@"50"];
            }
                break;
            case 902:{
                [text setText:@"100"];
            }
                break;
            case 903:{
                [text setText:@"300"];
            }
                break;
            case 904:{
                [text setText:@"500"];
            }
                break;
            case 905:{
                [text setText:@"800"];
            }
                break;
            case 906:{
                [text setText:@"1000"];
            }
                break;
            case 907:{
                [text setText:@"1500"];
            }
                break;
            case 908:{
                [text setText:@"2100"];
            }
                break;
            case 909:{
                [text setText:@"2700"];
            }
                break;
            case 910:{
                [text setText:@"3000"];
            }
                break;
            case 911:{
                [text setText:@"5000"];
            }
                break;
            case 912:{
                [text setText:@"10000"];
            }
                break;
        }
    }else if([self.paymentName isEqualToString:@"YFZF"]){
        for (int i = 1101; i < 1109; i++) {
            if (button.tag == i) {
                [button setTitleColor:BG_Nav forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor colorWithRed:249.0/255 green:228.0/255 blue:228.0/255 alpha:1]];
            }else{
                UIButton *myButton = [self viewWithTag:i];
                [myButton setBackgroundColor:[UIColor whiteColor]];
                [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
            }
        }
        
        UITextField *text = [self viewWithTag:10111];
        switch (button.tag) {
            case 1101:{
                [text setText:@"50"];
            }
                break;
            case 1102:{
                [text setText:@"100"];
            }
                break;
            case 1103:{
                [text setText:@"200"];
            }
                break;
            case 1104:{
                [text setText:@"500"];
            }
                break;
            case 1105:{
                [text setText:@"1000"];
            }
                break;
            case 1106:{
                [text setText:@"2000"];
            }
                break;
            case 1107:{
                [text setText:@"5000"];
            }
                break;
            case 1108:{
                [text setText:@"10000"];
            }
                break;
        }
    }else if([self.paymentName isEqualToString:@"KJFtemp"]){
        for (int i = 1901; i < 1909; i++) {
            if (button.tag == i) {
                [button setTitleColor:BG_Nav forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor colorWithRed:249.0/255 green:228.0/255 blue:228.0/255 alpha:1]];
            }else{
                UIButton *myButton = [self viewWithTag:i];
                [myButton setBackgroundColor:[UIColor whiteColor]];
                [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
            }
        }
        
        UITextField *text = [self viewWithTag:10111];
        switch (button.tag) {
            case 1901:{
                [text setText:@"50"];
            }
                break;
            case 1902:{
                [text setText:@"100"];
            }
                break;
            case 1903:{
                [text setText:@"200"];
            }
                break;
            case 1904:{
                [text setText:@"300"];
            }
                break;
            case 1905:{
                [text setText:@"500"];
            }
                break;
            case 1906:{
                [text setText:@"1000"];
            }
                break;
            case 1907:{
                [text setText:@"2000"];
            }
                break;
            case 1908:{
                [text setText:@"3000"];
            }
                break;
        }
    }else if([self.paymentName isEqualToString:@"XINFA"]){
        for (int i = 2001; i < 2008; i++) {
            if (button.tag == i) {
                [button setTitleColor:BG_Nav forState:UIControlStateNormal];
                [button setBackgroundColor:[UIColor colorWithRed:249.0/255 green:228.0/255 blue:228.0/255 alpha:1]];
            }else{
                UIButton *myButton = [self viewWithTag:i];
                [myButton setBackgroundColor:[UIColor whiteColor]];
                [myButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
            }
        }
        
        UITextField *text = [self viewWithTag:10111];
        switch (button.tag) {
            case 2001:{
                [text setText:@"20"];
            }
                break;
            case 2002:{
                [text setText:@"30"];
            }
                break;
            case 2003:{
                [text setText:@"50"];
            }
                break;
            case 2004:{
                [text setText:@"100"];
            }
                break;
            case 2005:{
                [text setText:@"200"];
            }
                break;
            case 2006:{
                [text setText:@"300"];
            }
                break;
            case 2007:{
                [text setText:@"500"];
            }
                break;
        }
    }else{
        for (int i = 201; i < 206; i++) {
            if (button.tag == i) {
                [button setTitleColor:BG_Nav forState:UIControlStateNormal];
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
}

- (void)buildBankList:(UIView *)bgView{
    UIView *moneyView = [self viewWithTag:1001];
    
    UIView *bankView = [[UIView alloc] init];
    [bankView setTag:10001];
    [bgView addSubview:bankView];
    [bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyView.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(55);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    line1.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bankView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(bankView);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [titleLabel setText:@"银行列表"];
    [titleLabel setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [bankView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankView).offset(10);
        make.left.equalTo(bankView).offset(10);
        make.height.mas_equalTo(45);
    }];
    
    UIImageView *leftImv = [[UIImageView alloc] init];
    [leftImv setImage:[UIImage imageNamed:@"cell_arrow_left"]];
    [bankView addSubview:leftImv];
    [leftImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankView).offset(22);
        make.trailing.equalTo(bankView).offset(-10);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *bankButton = [[UIButton alloc] init];
    [bankButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [bankButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    bankButton.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [bankButton setTag:1121];
    [bankButton setTitle:@"请选择支付列表" forState:UIControlStateNormal];
    [bankView addSubview:bankButton];
    [bankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankView).offset(10);
        make.left.equalTo(bankView).offset(80);
        make.right.equalTo(bankView).offset(-30);
        make.height.mas_equalTo(45);
    }];
    [bankButton addTarget:self action:@selector(bankButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = [UIColor colorWithRed:207.0/255 green:206.0/255 blue:210.0/255 alpha:1];
    [bankView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(bankView);
        make.height.mas_equalTo(1);
    }];
}

- (void)bankButtonClick:(UIButton *)button{
    
    XPFPickerView *picker = [[XPFPickerView alloc] init];
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"GBankList2" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    
    NSMutableArray *arrs = [[NSMutableArray alloc] init];
    for (int i=0; i<dataArrs.count; i++) {
        NSDictionary *dict = dataArrs[i];
        [arrs addObject:[dict objectForKey:@"title"]];
    }
    
    picker.array = [arrs copy];
    picker.title = @"银行列表";
    [picker show];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getValue:) name:@"XPFPickerView" object:nil];
}

- (void)getValue:(NSNotification *)notification {
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"GBankList2" ofType:@"plist"];
    NSMutableArray *dataArrs = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    
    for (int i=0; i<dataArrs.count; i++) {
        NSDictionary *dict = dataArrs[i];
        if([notification.object isEqualToString:[dict objectForKey:@"title"]]){
            self.bankcode = [dict objectForKey:@"bankcode"];
        }
    }
    
    UIButton *bankButton = [self viewWithTag:1121];
    [bankButton setTitle:notification.object forState:UIControlStateNormal];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buildBottomView:(UIView *)bgView{
    
    UIView *bankView = [self viewWithTag:10001];
    
    UIView *bottomView = [[UIView alloc] init];
    [bottomView setTag:10002];
    [bottomView setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    [bgView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bankView.mas_bottom);
        make.left.right.equalTo(bgView);
        make.height.mas_equalTo(220);
    }];
    
    UIButton *nextButton = [[UIButton alloc] init];
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
        make.width.equalTo(@150);
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
    
    button.enabled = NO;
    
    if([self.type isEqualToString:@"WYZF"]){
        if([self.bankcode isEqualToString:@""]){
            [SVProgressHUD showInfoWithStatus:@"请选择银行"];
            button.enabled = YES;
            return;
        }
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
        dicInfo[@"payId"] = self.payid;
        dicInfo[@"acounmt"] = self.moneyTextField.text;
        dicInfo[@"bankcode"] = self.bankcode;
        
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kOnlineBanking RequestWay:kGET withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
            self.moneyTextField.text = @"";
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            NSString *htmlStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            dict[@"html"] = [NSString stringWithFormat:@"%@",htmlStr];
            if (self.clikeNextCall) {
                self.clikeNextCall(dict);
            }
            button.enabled = YES;
        } failure:^(NSError *error) {
            button.enabled = YES;
            [SVProgressHUD showErrorWithStatus:kNetError];
        }];
    }else{
        NSMutableDictionary *dicInfo = [NSMutableDictionary dictionary];
        dicInfo[@"payId"] = self.payid;
        dicInfo[@"acounmt"] = self.moneyTextField.text;
        dicInfo[@"mobile"] = @"mobile";
        dicInfo[@"scancode"] = self.type;
        [[SZNetWorkingManager shareManager] sendHTTPDataWithBaseURL:[[SZUser shareUser] readBaseLink] andAppendURL:kScanPay RequestWay:kPOST withParamters:dicInfo withToken:nil success:^(BOOL isSuccess, id responseObject) {
            if([responseObject[@"status"] isEqualToString:@"success"]){
                
                self.moneyTextField.text = @"";
                [SVProgressHUD showSuccessWithStatus:responseObject[@"msg"]];
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
}

@end
