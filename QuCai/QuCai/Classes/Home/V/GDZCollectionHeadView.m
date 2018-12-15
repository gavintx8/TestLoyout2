//
//  GDZCollectionHeadView.m
//  QuCai
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GDZCollectionHeadView.h"
#import "UIView+Gradient.h"

@implementation GDZCollectionHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    self.imv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth - 20, 120)];
    [self.imv.layer setCornerRadius:3];
    self.imv.layer.masksToBounds = YES;
    [headView addSubview:self.imv];
    [self addSubview:headView];
    
    UIImageView *imv2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 10 - 87, 10, 87, 25)];
    imv2.image = [UIImage imageNamed:@"remen"];
    [headView addSubview:imv2];
}

-(void)getSHCollectionReusableViewHearderTitle:(NSString *)imgStr{
    
    self.imv.image = [UIImage imageNamed:imgStr];
}

@end
