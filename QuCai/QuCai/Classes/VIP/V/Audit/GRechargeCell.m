//
//  GRechargeCell.m
//  QuCai
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GRechargeCell.h"

@interface GRechargeCell()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *weakLabel;
@property (nonatomic, strong) UILabel *payTypeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *remarkTitleLabel;
@property (nonatomic, strong) UILabel *remarkLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation GRechargeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    UIView *contentView = [GUIHelper getViewWithColor:[UIColor colorWithHexStr:@"#f2f2f2"]];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.typeLabel = [[UILabel alloc] init];
    self.typeLabel.backgroundColor = [UIColor colorWithRed:252.0/255 green:80.0/255 blue:72.0/255 alpha:1];
    self.typeLabel.textColor = [UIColor whiteColor];
    self.typeLabel.font = [UIFont systemFontOfSize:14.f];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(20);
        make.left.equalTo(contentView).offset(20);
        make.height.width.mas_equalTo(30);
    }];
    self.typeLabel.layer.cornerRadius = 15;
    self.typeLabel.layer.masksToBounds = YES;
    
    self.weakLabel = [[UILabel alloc] init];
    self.weakLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.weakLabel.font = [UIFont systemFontOfSize:13.f];
    [contentView addSubview:self.weakLabel];
    [self.weakLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(60);
        make.centerY.equalTo(self.typeLabel);
        make.height.mas_equalTo(20);
    }];
    
    self.payTypeLabel = [[UILabel alloc] init];
    self.payTypeLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.payTypeLabel.font = [UIFont systemFontOfSize:13.f];
    [contentView addSubview:self.payTypeLabel];
    [self.payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(15);
        make.left.equalTo(self.weakLabel.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.stateLabel.font = [UIFont systemFontOfSize:13.f];
    [contentView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payTypeLabel.mas_bottom);
        make.left.equalTo(self.weakLabel.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.moneyLabel.font = [UIFont systemFontOfSize:13.f];
    [contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.stateLabel.mas_right).offset(50);
        make.centerY.equalTo(self.weakLabel);
        make.height.mas_equalTo(20);
    }];
    
    self.remarkTitleLabel = [[UILabel alloc] init];
    self.remarkTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.remarkTitleLabel.font = [UIFont systemFontOfSize:13.f];
    self.remarkTitleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:self.remarkTitleLabel];
    [self.remarkTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(15);
        make.right.equalTo(contentView).offset(-60);
        make.height.mas_equalTo(20);
    }];
    
    self.dateLabel = [[UILabel alloc] init];
    self.dateLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.dateLabel.font = [UIFont systemFontOfSize:13.f];
    [contentView addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    self.remarkLabel = [[UILabel alloc] init];
    self.remarkLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.remarkLabel.font = [UIFont systemFontOfSize:13.f];
    self.remarkLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remarkTitleLabel.mas_bottom);
        make.centerX.equalTo(self.remarkTitleLabel);
        make.height.mas_equalTo(20);
    }];
}

- (void)setRechargeModel:(GRechargeModel *)rechargeModel {
    
    self.typeLabel.text = @"存";
    self.weakLabel.text = [GTool weekdayStringFromDate:[GTool stringToDate:rechargeModel.order_time]];
    self.payTypeLabel.text = rechargeModel.pay_type;
    self.stateLabel.text = rechargeModel.trade_status;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@元",rechargeModel.order_amount];
    self.remarkTitleLabel.text = @"备注";
    self.dateLabel.text = rechargeModel.order_time;
    self.remarkLabel.text = rechargeModel.rmk;
}

@end
