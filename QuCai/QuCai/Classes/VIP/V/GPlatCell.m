//
//  GPlatCell.m
//  QuCai
//
//  Created by mac on 2017/7/14.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GPlatCell.h"

@interface GPlatCell()
{
    UIImageView *imv;
    UILabel *titleLabel;
    UILabel *moneyLabel;
}
@end

@implementation GPlatCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        
        imv = [[UIImageView alloc] init];
        [self addSubview:imv];
        [imv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(50);
        }];
        
        titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(90);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(30);
        }];
        
        moneyLabel = [[UILabel alloc] init];
        moneyLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:moneyLabel];
        [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-20);
            make.centerY.equalTo(self);
            make.height.mas_equalTo(30);
        }];

    }
    return self;
}

-(float)setData:(GPlatModel *)model and:(NSString *)name
{
    if ([model.money isEqualToString:@"维护中"] || [model.title isEqualToString:name]) {
        titleLabel.textColor = [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1];
        moneyLabel.textColor = [UIColor colorWithRed:208.0/255 green:208.0/255 blue:208.0/255 alpha:1];
    }else{
        titleLabel.textColor = [UIColor colorWithRed:109.0/255 green:109.0/255 blue:109.0/255 alpha:1];
        moneyLabel.textColor = [UIColor colorWithRed:109.0/255 green:109.0/255 blue:109.0/255 alpha:1];
    }
    titleLabel.text = model.title;
    moneyLabel.text = [GTool stringMoneyFamat:model.money];
    [imv setImage:[UIImage imageNamed:model.image_url]];
    return 60.f;
}

@end
