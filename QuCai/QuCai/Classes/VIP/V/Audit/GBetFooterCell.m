//
//  GBetFooterCell.m
//  QuCai
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBetFooterCell.h"

@interface GBetFooterCell()

@property (nonatomic, strong) UILabel *betamountTotalLabel;
@property (nonatomic, strong) UILabel *betamountSumLabel;
@property (nonatomic, strong) UILabel *payoutSumLabel;
@property (nonatomic, strong) UILabel *netAmountSumLabel;
@property (nonatomic, strong) UILabel *netAmountTotalLabel;
@property (nonatomic, strong) UILabel *payoutTotalLabel;

@property (nonatomic, strong) UILabel *betamountTotalTitleLabel;
@property (nonatomic, strong) UILabel *betamountSumTitleLabel;
@property (nonatomic, strong) UILabel *payoutSumTitleLabel;
@property (nonatomic, strong) UILabel *netAmountSumTitleLabel;
@property (nonatomic, strong) UILabel *netAmountTotalTitleLabel;
@property (nonatomic, strong) UILabel *payoutTotalTitleLabel;

@end

@implementation GBetFooterCell

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
    
    self.betamountSumTitleLabel = [[UILabel alloc] init];
    self.betamountSumTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.betamountSumTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.betamountSumTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.betamountSumTitleLabel];
    [self.betamountSumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.betamountSumLabel = [[UILabel alloc] init];
    self.betamountSumLabel.textAlignment = NSTextAlignmentCenter;
    self.betamountSumLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.betamountSumLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.betamountSumLabel];
    [self.betamountSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.betamountSumTitleLabel.mas_bottom);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.payoutSumTitleLabel = [[UILabel alloc] init];
    self.payoutSumTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.payoutSumTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.payoutSumTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.payoutSumTitleLabel];
    [self.payoutSumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.equalTo(self.betamountSumTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.payoutSumLabel = [[UILabel alloc] init];
    self.payoutSumLabel.textAlignment = NSTextAlignmentCenter;
    self.payoutSumLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.payoutSumLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.payoutSumLabel];
    [self.payoutSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payoutSumTitleLabel.mas_bottom);
        make.left.equalTo(self.betamountSumLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.netAmountSumTitleLabel = [[UILabel alloc] init];
    self.netAmountSumTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.netAmountSumTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.netAmountSumTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.netAmountSumTitleLabel];
    [self.netAmountSumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.left.equalTo(self.payoutSumTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.netAmountSumLabel = [[UILabel alloc] init];
    self.netAmountSumLabel.textAlignment = NSTextAlignmentCenter;
    self.netAmountSumLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.netAmountSumLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.netAmountSumLabel];
    [self.netAmountSumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.netAmountSumTitleLabel.mas_bottom);
        make.left.equalTo(self.payoutSumLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    
    self.betamountTotalTitleLabel = [[UILabel alloc] init];
    self.betamountTotalTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.betamountTotalTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.betamountTotalTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.betamountTotalTitleLabel];
    [self.betamountTotalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.betamountSumLabel.mas_bottom).offset(5);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.betamountTotalLabel = [[UILabel alloc] init];
    self.betamountTotalLabel.textAlignment = NSTextAlignmentCenter;
    self.betamountTotalLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.betamountTotalLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.betamountTotalLabel];
    [self.betamountTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.betamountTotalTitleLabel.mas_bottom);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.payoutTotalTitleLabel = [[UILabel alloc] init];
    self.payoutTotalTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.payoutTotalTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.payoutTotalTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.payoutTotalTitleLabel];
    [self.payoutTotalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.betamountSumLabel.mas_bottom).offset(5);
        make.left.equalTo(self.betamountTotalTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.payoutTotalLabel = [[UILabel alloc] init];
    self.payoutTotalLabel.textAlignment = NSTextAlignmentCenter;
    self.payoutTotalLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.payoutTotalLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.payoutTotalLabel];
    [self.payoutTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payoutTotalTitleLabel.mas_bottom);
        make.left.equalTo(self.betamountTotalTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.netAmountTotalTitleLabel = [[UILabel alloc] init];
    self.netAmountTotalTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.netAmountTotalTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.netAmountTotalTitleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    [contentView addSubview:self.netAmountTotalTitleLabel];
    [self.netAmountTotalTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.betamountSumLabel.mas_bottom).offset(5);
        make.left.equalTo(self.payoutTotalTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
    
    self.netAmountTotalLabel = [[UILabel alloc] init];
    self.netAmountTotalLabel.textAlignment = NSTextAlignmentCenter;
    self.netAmountTotalLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.netAmountTotalLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.netAmountTotalLabel];
    [self.netAmountTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payoutTotalTitleLabel.mas_bottom);
        make.left.equalTo(self.payoutTotalLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/3);
    }];
}

- (void)setBetFooterDict:(NSDictionary *)dict {
    
    self.betamountTotalTitleLabel.text = @"下注金额总计";
    self.betamountSumTitleLabel.text = @"下注金额小计";
    self.payoutSumTitleLabel.text = @"派彩金额小计";
    self.netAmountSumTitleLabel.text = @"输赢金额小计";
    self.netAmountTotalTitleLabel.text = @"输赢金额总计";
    self.payoutTotalTitleLabel.text = @"派彩金额总计";
    
    self.betamountTotalLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"betamountTotal"]];
    self.betamountSumLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"betamountSum"]];
    self.payoutSumLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"payoutSum"]];
    self.netAmountSumLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"netAmountSum"]];
    self.netAmountTotalLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"netAmountTotal"]];
    self.payoutTotalLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"payoutTotal"]];
}
@end
