//
//  GFundHeadView.m
//  QuCai
//
//  Created by mac on 2017/7/14.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GFundHeadView.h"

@interface GFundHeadView ()

@end

@implementation GFundHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexStr:@"#35AEA0"];
        [self customHeaderView];
    }
    
    return self;
}

-(void)customHeaderView
{
    UIImageView *headImv = [[UIImageView alloc] init];
    [headImv setImage:[UIImage imageNamed:@"zichan_blue"]];
    [self addSubview:headImv];
    [headImv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(250);
    }];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"nav_back_white"] forState:UIControlStateNormal];
    [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(60);
        make.left.equalTo(self).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
    }];
    [backButton addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _fundLabel = [[UILabel alloc] init];
    _fundLabel.font = [UIFont boldSystemFontOfSize:20];
    _fundLabel.textColor = [UIColor whiteColor];
    _fundLabel.textAlignment = NSTextAlignmentCenter;
    _fundLabel.text = [GTool stringMoneyFamat:[[SZUser shareUser] readBalance]];
    [self addSubview:_fundLabel];
    [_fundLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@80);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"总资产(元)";
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fundLabel.mas_bottom);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    [self addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(self);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    [label setText:@"资金明细"];
    [label setFont:[UIFont systemFontOfSize:14.f]];
    [label setTextColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1]];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
        make.left.equalTo(headerView).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *quotaButton = [[UIButton alloc] init];
    [quotaButton setTitleColor:[UIColor colorWithRed:141.0/255 green:142.0/255 blue:144.0/255 alpha:1] forState:UIControlStateNormal];
    [quotaButton setTitle:@"刷新额度" forState:UIControlStateNormal];
    quotaButton.titleLabel.font = [UIFont systemFontOfSize: 14.f];
    [quotaButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [headerView addSubview:quotaButton];
    [quotaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView);
        make.right.equalTo(headerView).offset(-20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    [quotaButton addTarget:self action:@selector(quotaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)quotaButtonClick:(UIButton *)button{
    if (self.clikeCall2) {
        self.clikeCall2(button.tag);
    }
}

- (void)backButtonClick:(UIButton *)button{
    if (self.clikeCall) {
        self.clikeCall(button.tag);
    }
}

@end
