//
//  GDrawCell.m
//  QuCai
//
//  Created by mac on 2017/7/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GDrawCell.h"

@interface GDrawCell()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *cardNumberLabel;
@property (nonatomic, strong) UILabel *drawTitleLabel;
@property (nonatomic, strong) UILabel *sxfTitleLabel;
@property (nonatomic, strong) UILabel *ssTitleLabel;
@property (nonatomic, strong) UILabel *stateTitleLabel;
@property (nonatomic, strong) UILabel *drawLabel;
@property (nonatomic, strong) UILabel *sxfLabel;
@property (nonatomic, strong) UILabel *ssLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *addTimeLabel;

@end

@implementation GDrawCell

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
    self.typeLabel.font = [UIFont systemFontOfSize:14.f];
    self.typeLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:self.typeLabel];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(15);
        make.left.equalTo(contentView).offset(20);
        make.height.width.mas_equalTo(30);
    }];
    self.typeLabel.layer.cornerRadius = 15;
    self.typeLabel.layer.masksToBounds = YES;
    
    self.cardNumberLabel = [[UILabel alloc] init];
    self.cardNumberLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.cardNumberLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.cardNumberLabel];
    [self.cardNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(20);
        make.centerY.equalTo(self.typeLabel);
        make.height.mas_equalTo(20);
    }];
    
    self.drawTitleLabel = [[UILabel alloc] init];
    self.drawTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.drawTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.drawTitleLabel.font = [UIFont boldSystemFontOfSize:13.f];
    [contentView addSubview:self.drawTitleLabel];
    [self.drawTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(5);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    
    self.sxfTitleLabel = [[UILabel alloc] init];
    self.sxfTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.sxfTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.sxfTitleLabel.font = [UIFont boldSystemFontOfSize:13.f];
    [contentView addSubview:self.sxfTitleLabel];
    [self.sxfTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(5);
        make.left.equalTo(self.drawTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    
    self.ssTitleLabel = [[UILabel alloc] init];
    self.ssTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.ssTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.ssTitleLabel.font = [UIFont boldSystemFontOfSize:13.f];
    [contentView addSubview:self.ssTitleLabel];
    [self.ssTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(5);
        make.left.equalTo(self.sxfTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    
    self.stateTitleLabel = [[UILabel alloc] init];
    self.stateTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.stateTitleLabel.textColor = [UIColor colorWithRed:34.0/255 green:34.0/255 blue:34.0/255 alpha:1];
    self.stateTitleLabel.font = [UIFont boldSystemFontOfSize:13.f];
    [contentView addSubview:self.stateTitleLabel];
    [self.stateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).offset(5);
        make.left.equalTo(self.ssTitleLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    
    self.drawLabel = [[UILabel alloc] init];
    self.drawLabel.textAlignment = NSTextAlignmentCenter;
    self.drawLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.drawLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.drawLabel];
    [self.drawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stateTitleLabel.mas_bottom);
        make.left.equalTo(contentView);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    
    self.sxfLabel = [[UILabel alloc] init];
    self.sxfLabel.textAlignment = NSTextAlignmentCenter;
    self.sxfLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.sxfLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.sxfLabel];
    [self.sxfLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stateTitleLabel.mas_bottom);
        make.left.equalTo(self.drawLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    
    self.ssLabel = [[UILabel alloc] init];
    self.ssLabel.textAlignment = NSTextAlignmentCenter;
    self.ssLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.ssLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.ssLabel];
    [self.ssLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stateTitleLabel.mas_bottom);
        make.left.equalTo(self.sxfLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    
    self.stateLabel = [[UILabel alloc] init];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.stateLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stateTitleLabel.mas_bottom);
        make.left.equalTo(self.ssLabel.mas_right);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(kScreenWidth/4);
    }];
    
    self.addTimeLabel = [[UILabel alloc] init];
    self.addTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.addTimeLabel.textColor = [UIColor colorWithRed:155.0/255 green:155.0/255 blue:155.0/255 alpha:1];
    self.addTimeLabel.font = [UIFont systemFontOfSize:12.f];
    [contentView addSubview:self.addTimeLabel];
    [self.addTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.stateLabel.mas_bottom);
        make.left.equalTo(contentView).offset(10);
        make.height.mas_equalTo(20);
    }];
}

- (void)setDrawModel:(GDrawModel *)drawModel {
    
    self.typeLabel.text = @"取";
    self.cardNumberLabel.text = drawModel.card_num;
    self.drawTitleLabel.text = @"取款金额";
    self.sxfTitleLabel.text = @"手续费";
    self.ssTitleLabel.text = @"实收金额";
    self.stateTitleLabel.text = @"状态";
    self.drawLabel.text = [NSString stringWithFormat:@"%@元",drawModel.amount];
    self.sxfLabel.text = [NSString stringWithFormat:@"%@元",drawModel.poundage];
    self.ssLabel.text = [NSString stringWithFormat:@"%@元",drawModel.amount_paid];
    self.stateLabel.text = drawModel.status;
    self.addTimeLabel.text = drawModel.add_time;
}

@end
