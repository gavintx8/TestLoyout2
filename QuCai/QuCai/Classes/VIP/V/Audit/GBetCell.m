//
//  GBetCell.m
//  QuCai
//
//  Created by mac on 2017/7/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBetCell.h"

@interface GBetCell()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *tTimeLabel;
@property (nonatomic, strong) UILabel *moneyTitleLabel;
@property (nonatomic, strong) UILabel *startMoneyTitleLabel;
@property (nonatomic, strong) UILabel *endMoneyTitleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *startMoneyLabel;
@property (nonatomic, strong) UILabel *endMoneyLabel;

@end

@implementation GBetCell

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
    self.typeLabel.font = [UIFont systemFontOfSize:13.f];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(10);
        make.left.equalTo(contentView).offset(10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(60);
    }];
    self.typeLabel.layer.cornerRadius = 6;
    self.typeLabel.layer.masksToBounds = YES;
    
    self.tTimeLabel = [[UILabel alloc] init];
    self.tTimeLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.tTimeLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.tTimeLabel];
    [self.tTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(50);
        make.centerY.equalTo(self.typeLabel);
        make.height.mas_equalTo(20);
    }];
    
    self.moneyTitleLabel = [[UILabel alloc] init];
    self.moneyTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.moneyTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.moneyTitleLabel];
    [self.moneyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.startMoneyTitleLabel = [[UILabel alloc] init];
    self.startMoneyTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.startMoneyTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.startMoneyTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.startMoneyTitleLabel];
    [self.startMoneyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.moneyTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.endMoneyTitleLabel = [[UILabel alloc] init];
    self.endMoneyTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.endMoneyTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.endMoneyTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.endMoneyTitleLabel];
    [self.endMoneyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.startMoneyTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.textAlignment = NSTextAlignmentCenter;
    self.moneyLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.moneyLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.startMoneyLabel = [[UILabel alloc] init];
    self.startMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.startMoneyLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.startMoneyLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.startMoneyLabel];
    [self.startMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.moneyLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.endMoneyLabel = [[UILabel alloc] init];
    self.endMoneyLabel.textAlignment = NSTextAlignmentCenter;
    self.endMoneyLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.endMoneyLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.endMoneyLabel];
    [self.endMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyTitleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.startMoneyLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
}

- (void)setBetModel:(GBetModel *)betModel {
    self.typeLabel.text = betModel.type;
    self.tTimeLabel.text = betModel.bettime;
    self.moneyTitleLabel.text = @"下注金额";
    self.startMoneyTitleLabel.text = @"派彩金额";
    self.endMoneyTitleLabel.text = @"输赢金额";
    self.moneyLabel.text = betModel.betAmount;
    self.startMoneyLabel.text = betModel.Payout;
    self.endMoneyLabel.text = betModel.netAmount;
}

@end
