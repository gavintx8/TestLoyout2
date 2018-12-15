//
//  GTheSecondModuleCollectionViewCell.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/24.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GTheSecondModuleCollectionViewCell.h"

@implementation GTheSecondModuleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    UIView *backView = [GUIHelper getViewWithColor:[UIColor whiteColor]];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIImageView *contentView = [GUIHelper getImageViewImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [backView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(4, 4, 0, 4));
    }];
//    contentView.layer.cornerRadius = 5;
//    contentView.layer.masksToBounds = YES;
    
    self.imv = [[UIImageView alloc] init];
    [contentView addSubview:self.imv];
    [self.imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-8);
        make.width.height.mas_equalTo(50);
    }];
//    self.imv.layer.cornerRadius = 51/2;
//    self.imv.image = [UIImage imageNamed:@"card"];
    
    self.label1 = [GUIHelper getLabel:TXT_SIZE_13 andTextColor:[UIColor colorWithHexStr:@"#666666"]];
    [self addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imv);
        make.top.equalTo(self.imv.mas_bottom).offset(6);
    }];
//    self.label1.text = @"一分时时彩";
    
    self.label2 = [GUIHelper getLabel:TXT_SIZE_13 andTextColor:[UIColor colorWithHexStr:@"#666666"]];
    [self addSubview:self.label2];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1);
        make.top.equalTo(self.label1.mas_bottom).offset(4);
    }];
//    self.label2.text = @"一分时时彩";
}

@end
