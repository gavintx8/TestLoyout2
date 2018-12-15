//
//  GEECollectionViewCell.m
//  QuCai
//
//  Created by tx gavin on 2017/6/26.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GEECollectionViewCell.h"

@implementation GEECollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    UIView *backView = [[UIView alloc] init];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
    backView.layer.cornerRadius = 2;
    backView.layer.masksToBounds = YES;
    
    UIImageView *contentView = [[UIImageView alloc] init];
    [contentView setImage:[UIImage imageNamed:@"bg"]];
    [backView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(4, 4, 4, 4));
    }];
    self.contentView.contentMode = UIViewContentModeScaleAspectFit;
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    
    self.label1 = [GUIHelper getLabel:TXT_SIZE_13 andTextColor:[UIColor whiteColor]];
    [self addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_top).offset(8);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(90);
    }];
    self.label1.textAlignment = NSTextAlignmentCenter;
    self.label1.layer.cornerRadius = 2;
    self.label1.layer.masksToBounds = YES;
    
    self.imv = [[UIImageView alloc] init];
    self.imv.contentMode = UIViewContentModeScaleAspectFit;
    [contentView addSubview:self.imv];
    [self.imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label1.mas_bottom).offset(10);
        make.centerX.equalTo(self.label1);
    }];
    self.imv.layer.cornerRadius = 51/2;

}

@end
