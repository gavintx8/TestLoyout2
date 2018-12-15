//
//  GDZCollectionViewCell.m
//  QuCai
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GDZCollectionViewCell.h"

@implementation GDZCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    
    UIView *backView = [[UIView alloc] init];
    [backView setBackgroundColor:[UIColor whiteColor]];
    [backView.layer setBorderColor:Them_Color.CGColor];
    [backView.layer setBorderWidth:1.f];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    backView.layer.cornerRadius = 2;
    backView.layer.masksToBounds = YES;
    
    self.imv = [[UIImageView alloc] init];
    [self addSubview:self.imv];
    [self.imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    
    self.label1 = [GUIHelper getLabel:TXT_SIZE_14 andTextColor:Title_black];
    [self addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imv.mas_bottom).offset(5);
        make.centerX.equalTo(self.imv);
        make.height.mas_equalTo(20);
    }];
    self.label1.textAlignment = NSTextAlignmentCenter;
}

@end
