//
//  GLotterySegmentHeaderView.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GLotterySegmentHeaderView.h"

@implementation GLotterySegmentHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    self.titleLabel = [GUIHelper getLabel:TXT_SIZE_15 andTextColor:[UIColor colorWithHexStr:@"#666666"]];
    self.backgroundColor  = Them_Color;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self);
    }];
}

-(void)getSHCollectionReusableViewHearderTitle:(NSString *)title{
    
    _titleLabel.text=title;
    
}

@end
