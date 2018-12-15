//
//  GRightTableViewCell.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/6.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GRightTableViewCell.h"

@implementation GRightTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    
    return self;
}

- (void)createUI {
    self.backgroundColor = [UIColor whiteColor];
    self.imv1 = [[UIImageView alloc] init];
    [self addSubview:self.imv1];
    [self.imv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(6);
        make.left.equalTo(self.mas_left).offset(8);
        make.width.mas_equalTo(145);
        make.height.mas_equalTo(80);
    }];
    
    self.label1 = [GUIHelper getLabel:nil andFont:TXT_SIZE_14 andTextColor:[UIColor colorWithHexStr:@"#000000"]];
    [self addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imv1.mas_right).offset(8);
        make.top.equalTo(self.imv1.mas_top).offset(5);
    }];
    
    self.label2 = [GUIHelper getLabel:nil andFont:TXT_SIZE_11 andTextColor:[UIColor colorWithHexStr:@"#666666"]];
    [self addSubview:self.label2];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label1);
        make.top.equalTo(self.label1.mas_bottom).offset(6);
    }];
    
    self.enterGameButton = [[UIButton alloc] init];
    [self addSubview:self.enterGameButton];
    [self.enterGameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.label2);
        make.top.equalTo(self.label2.mas_bottom).offset(8);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(25);
    }];
    self.enterGameButton.layer.borderWidth = 1;
    [self.enterGameButton.layer setBorderColor:BG_Nav.CGColor];
    [self.enterGameButton.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [self.enterGameButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [self.enterGameButton setTitle:@"开始游戏" forState:UIControlStateNormal];
    [self.enterGameButton setTitleColor:BG_Nav forState:UIControlStateNormal];
    [self.enterGameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.enterGameButton setBackgroundImage:[UIImage imageWithColor:BG_Nav] forState:UIControlStateHighlighted];
    self.enterGameButton.layer.cornerRadius = 12;
    self.enterGameButton.layer.masksToBounds = YES;
    [self.enterGameButton addTarget:self action:@selector(enterGameButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)enterGameButtonClick:(UIButton *)button{
    if (self.clickEnterGameBlock) {
        self.clickEnterGameBlock(button.tag);
    }
}

- (void)clickEnterGameWithBlock:(handleEnterGameButtonBlock)clickEnterGameBlock{
    if (clickEnterGameBlock) {
        _clickEnterGameBlock = clickEnterGameBlock;
    }
}

@end
