//
//  GLeftTableviewCell.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/6.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GLeftTableviewCell.h"

@implementation GLeftTableviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    self.backgroundColor = Them_Color;
    
    self.label = [GUIHelper getLabel:nil andFont:TXT_SIZE_14 andTextColor:[UIColor colorWithHexStr:@"#000000"]];
    [self addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    self.lineView = [GUIHelper getViewWithColor:Them_Color];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo(4);
    }];
}

@end
