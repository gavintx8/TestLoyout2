//
//  GAddCardVc.m
//  QuCai
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GAddCardVc.h"
#import "GNewAddBankCardVc.h"

@interface GAddCardVc ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation GAddCardVc

- (void) onCreate {
    
    [self setupNav];
    [self buildAddCardView:self.view];
}

- (void) onWillShow {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)setupNav {
    [self.view setBackgroundColor:[UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1]];
    self.navigationItem.title = @"银行卡";
    
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
}

- (void)addButtonClick:(UIButton *)button{
    
    GNewAddBankCardVc *addCardVc = [[GNewAddBankCardVc alloc] init];
    [self.navigationController pushViewController:addCardVc animated:YES];
}

@end
