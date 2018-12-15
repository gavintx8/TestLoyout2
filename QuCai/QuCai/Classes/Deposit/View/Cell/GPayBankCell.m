//
//  GCAttributeItemCell.m
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GPayBankCell.h"
#import "GFiltrateItem.h"
#import "GPayBankItem.h"

@interface GPayBankCell ()

@property (strong , nonatomic)UIButton *contentButton;
@property (strong , nonatomic)UIImageView *imv;

@end

@implementation GPayBankCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _contentButton.userInteractionEnabled = NO;
    [self addSubview:_contentButton];
    _contentButton.titleLabel.font = PFR15Font;
    [_contentButton setTitleColor:[UIColor blackColor] forState:0];
    _contentButton.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    
    CGRect titleFrame = _contentButton.titleLabel.frame;
    CGRect imageFrame = _contentButton.imageView.frame;
    CGFloat space = titleFrame.origin.x - imageFrame.origin.x - imageFrame.size.width + 14;
    [_contentButton setTitleEdgeInsets:UIEdgeInsetsMake(0,titleFrame.size.width + space+10, 0, -(titleFrame.size.width + space))];
    [_contentButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, titleFrame.origin.x - imageFrame.origin.x)];
    
    NSString *urlStr = [[NSBundle mainBundle]pathForResource:@"zftj" ofType:@"gif"];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    self.iv = [FLAnimatedImageView new];
    [self.iv sd_setImageWithURL:url];
    [self addSubview:self.iv];
    [self.iv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentButton.mas_top).offset(5);
        make.right.equalTo(self.contentButton.mas_right).offset(-5);
        make.height.mas_equalTo(12);
        make.width.mas_equalTo(30);
    }];
    self.iv.hidden = YES;
    
    self.imv = [[UIImageView alloc] init];
    [self.imv setImage:[UIImage imageNamed:@"icon_xuanze"]];
    [self addSubview:self.imv];
    [self.imv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentButton.mas_right);
        make.bottom.equalTo(self.contentButton.mas_bottom);
    }];
    self.imv.hidden = YES;
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setContentItem:(GPayBankItem *)contentItem
{
    _contentItem = contentItem;
    [_contentButton setTitle:contentItem.content forState:0];
    [_contentButton setImage:[UIImage imageNamed:contentItem.image] forState:0];
    
    if (contentItem.isSelect) {
        self.imv.hidden = NO;
        [_contentButton setTitleColor:[UIColor colorWithRed:115.0/255 green:128.0/255 blue:129.0/255 alpha:1] forState:UIControlStateNormal];
        _contentButton.backgroundColor = [UIColor whiteColor];

        [GTool dc_chageControlCircularWith:self AndSetCornerRadius:0 SetBorderWidth:1 SetBorderColor:BG_Nav canMasksToBounds:YES];
    }else{
        self.imv.hidden = YES;
        [_contentButton setTitleColor:[UIColor colorWithRed:115.0/255 green:128.0/255 blue:129.0/255 alpha:1] forState:UIControlStateNormal];
        _contentButton.backgroundColor = [UIColor whiteColor];
        
        [GTool dc_chageControlCircularWith:self AndSetCornerRadius:0 SetBorderWidth:1 SetBorderColor:[UIColor colorWithRed:214.0/255 green:214.0/255 blue:214.0/255 alpha:1] canMasksToBounds:YES];
    }
}

@end
