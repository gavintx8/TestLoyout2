//
//  GCardCell.m
//  QuCai
//
//  Created by mac on 2017/7/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GCardCell.h"

@interface GCardCell()
{
    UILabel *bankNameLabel;
    UILabel *bankCardLabel;
}
@end

@implementation GCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        
        bankNameLabel = [[UILabel alloc] init];
        bankNameLabel.font = [UIFont boldSystemFontOfSize:18];
        bankNameLabel.textColor = [UIColor colorWithRed:83.0/255 green:83.0/255 blue:83.0/255 alpha:1];
        [self addSubview:bankNameLabel];
        [bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.top.equalTo(self).offset(20);
            make.height.mas_equalTo(30);
        }];
        
        bankCardLabel = [[UILabel alloc] init];
        bankCardLabel.font = [UIFont boldSystemFontOfSize:18];
        bankCardLabel.textColor = [UIColor colorWithRed:83.0/255 green:83.0/255 blue:83.0/255 alpha:1];
        [self addSubview:bankCardLabel];
        [bankCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.top.equalTo(self->bankNameLabel.mas_bottom);
            make.height.mas_equalTo(30);
        }];
        
    }
    return self;
}

- (void)setData:(NSDictionary *)dict{
    bankNameLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"bank_name"]];
    bankCardLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"card_num"]];
}

@end
