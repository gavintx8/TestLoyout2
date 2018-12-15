//
//  GEECollectionHeadView.m
//  QuCai
//
//  Created by tx gavin on 2017/6/26.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GEECollectionHeadView.h"
#import "UIView+Gradient.h"

@implementation GEECollectionHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self setGradientBackgroundWithColors:@[[UIColor colorWithRed:40.0/255 green:213.0/255 blue:60.0/255 alpha:1],[UIColor colorWithRed:42.0/255 green:173.0/255 blue:194.0/255 alpha:1]] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    self.titleLabel = [GUIHelper getLabel:TXT_SIZE_18 andTextColor:[UIColor whiteColor]];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(19);
        make.centerY.equalTo(self);
    }];
}

-(void)getSHCollectionReusableViewHearderTitle:(NSString *)title{
    
    _titleLabel.text=title;
}
@end
