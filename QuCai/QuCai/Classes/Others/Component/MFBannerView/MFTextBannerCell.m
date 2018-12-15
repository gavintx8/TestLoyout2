//
//  MFTextBannerCell.m
//  MFBannerView
//
//  Created by 董宝君 on 2017/8/22.
//  Copyright © 2017年 董宝君. All rights reserved.
//

#import "MFTextBannerCell.h"

@interface MFTextBannerCell()
@property (nonatomic, weak) UILabel *label;
@end

@implementation MFTextBannerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imv = [[UIImageView alloc] init];
        [self addSubview:imv];
        _imv = imv;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _imv.frame = self.bounds;
}

@end
