//
//  GFooterEmptyView.m
//  QuCai
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GFooterEmptyView.h"

@implementation GFooterEmptyView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark - Setter Getter Methods

- (void)createUI{
    UIView *bgView = [[UIView alloc] init];
    self.backgroundColor = [UIColor colorWithRed:239.0/255 green:239.0/255 blue:239.0/255 alpha:1];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(10);
        make.leading.equalTo(self).offset(10);
        make.trailing.equalTo(self).offset(-10);
        make.height.mas_equalTo(130);
    }];
    [bgView.layer setCornerRadius:5];
    bgView.layer.masksToBounds = YES;
    
    UIButton *tipButton = [self createButtonTag:@"没有可用支付商列表！" and:104];
    [tipButton setImage:[UIImage imageNamed:@"icon_tanhao"] forState:UIControlStateNormal];
    [bgView addSubview:tipButton];
    [tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bgView);
        make.centerX.equalTo(bgView).offset(-50);
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
        make.left.equalTo(tipButton.mas_right).offset(-30);
        make.height.mas_equalTo(35);
    }];
    [serviceButton setTitleColor:[UIColor colorWithRed:187.0/255 green:150.0/255 blue:98.0/255 alpha:1] forState:UIControlStateNormal];
    [serviceButton addTarget:self action:@selector(serviceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
    return btn;
}

- (void)serviceButtonClick:(UIButton *)button{
    if (self.clikeCall) {
        self.clikeCall(button.tag);
    }
}

@end
