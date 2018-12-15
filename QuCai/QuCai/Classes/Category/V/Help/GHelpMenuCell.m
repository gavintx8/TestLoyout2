//
//  GHelpMenuCell.m
//  QuCai
//
//  Created by tx gavin on 2017/7/7.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GHelpMenuCell.h"

@implementation GHelpMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.lbl = [[UILabel alloc] init];
    self.lbl.textColor = [UIColor colorWithRed:133.0/255 green:144.0/255 blue:145.0/255 alpha:1];
    [self.lbl setFont:[UIFont systemFontOfSize:14.f]];
    [contentView addSubview:self.lbl];
    [self.lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.leading.equalTo(contentView).offset(20);
        make.height.mas_equalTo(30);
    }];
    
    UIImageView *imv = [[UIImageView alloc] init];
    imv.image = [UIImage imageNamed:@"cell_arrow_left"];
    [contentView addSubview:imv];
    [imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.trailing.equalTo(contentView).offset(-20);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
}
@end
