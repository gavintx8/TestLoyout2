//
//  GJournalCell.m
//  QuCai
//
//  Created by mac on 2017/7/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GJournalCell.h"

@interface GJournalCell()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *addTimeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *remarkLabel;

@end

@implementation GJournalCell

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
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView).offset(10);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(40);
    }];
    self.typeLabel.layer.cornerRadius = 6;
    self.typeLabel.layer.masksToBounds = YES;

    self.addTimeLabel = [[UILabel alloc] init];
    self.addTimeLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.addTimeLabel.font = [UIFont systemFontOfSize:12.f];
    self.addTimeLabel.numberOfLines = 0;
    self.addTimeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [contentView addSubview:self.addTimeLabel];
    [self.addTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(10);
        make.centerY.equalTo(self.typeLabel);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(80);
    }];
    
    self.amountLabel = [[UILabel alloc] init];
    self.amountLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.amountLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addTimeLabel.mas_right).offset(20);
        make.top.equalTo(self.addTimeLabel.mas_top).offset(-5);
        make.height.mas_equalTo(20);
    }];

    self.moneyLabel = [[UILabel alloc] init];
    self.moneyLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.moneyLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addTimeLabel.mas_right).offset(20);
        make.top.equalTo(self.amountLabel.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    self.remarkLabel = [[UILabel alloc] init];
    self.remarkLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.remarkLabel.font = [UIFont systemFontOfSize:12.f];
    self.remarkLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:self.remarkLabel];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView);
        make.left.equalTo(self.moneyLabel.mas_right);
        make.centerY.equalTo(self.typeLabel);
        make.height.mas_equalTo(20);
    }];
}

- (void)setJournalModel:(GJournalModel *)journalModel {
    
    self.typeLabel.text = journalModel.t_type;
    self.addTimeLabel.text = journalModel.addtime;
    self.amountLabel.text = [NSString stringWithFormat:@"金额：%@元",journalModel.amount];
    self.moneyLabel.text = [NSString stringWithFormat:@"钱包：%@元",journalModel.money];
    self.remarkLabel.text = journalModel.rmk;
}
@end
