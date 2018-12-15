//
//  GNewActivityCell.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/1.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GNewActivityCell.h"

@implementation GNewActivityCell

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
    
    self.imv = [[UIImageView alloc] init];
    self.imv = self.imv;
    self.imv.tag = 101;
    self.imv.contentMode = UIViewContentModeScaleAspectFit;
    [contentView addSubview:self.imv];
    [self.imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenW - 20);
        make.centerX.centerY.equalTo(contentView);
    }];
    self.imv.layer.cornerRadius = 8;
    self.imv.layer.masksToBounds = YES;
    [self.imv layoutIfNeeded];
}

- (void)setGNewActivityModel:(GNewActivityModel *)gNewActivityModel {
    
    _gNewActivityModel = gNewActivityModel;
    NSString *imageUrl = [GTool stringChineseFamat:gNewActivityModel.img1];
    [self.imv sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil options:0 progress:nil completed:nil];
    
}

@end
