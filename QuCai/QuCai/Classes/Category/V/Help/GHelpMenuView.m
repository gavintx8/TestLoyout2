//
//  GHelpMenuView.m
//  QuCai
//
//  Created by tx gavin on 2017/7/7.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GHelpMenuView.h"
#import "GTitleIconView.h"

@interface GHelpMenuView ()
@property (nonatomic, strong) NSArray *mens;
@end

@implementation GHelpMenuView
{
    HelpMenuBlock _helpMenuBlock;
}

static const NSInteger DefaultRowNumbers = 4;

- (instancetype)initMenu:(NSArray <GTitleIconAction *>*)mens helpMenuBlock:(void (^)(NSInteger))helpMenuBlock WithLine:(BOOL)line{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        if (helpMenuBlock) {
            _helpMenuBlock = helpMenuBlock;
        }
        self.mens = mens;
        for (GTitleIconAction *title in mens) {
            GTitleIconView *titleIconView = [[GTitleIconView alloc]initWithTitleLabel:title.title icon:title.icon boder:line];
            titleIconView.tag = title.tag;
            titleIconView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleIconViewClick:)];
            [titleIconView addGestureRecognizer:tap];
            [self addSubview:titleIconView];
        }
    }
    return self;
}

- (void)titleIconViewClick:(UITapGestureRecognizer *)gesture{
    if (_helpMenuBlock) {
        _helpMenuBlock(gesture.view.tag);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width / DefaultRowNumbers;
    CGFloat height = self.bounds.size.height / (self.mens.count / DefaultRowNumbers);
    
    for (int i = 0; i < self.subviews.count; ++i) {
        GTitleIconView *titleIconView = self.subviews[i];
        CGFloat viewX = (i % DefaultRowNumbers) * width;
        CGFloat viewY = (i / DefaultRowNumbers) * height;
        titleIconView.frame = CGRectMake(viewX, viewY, width, height);
    }
    
}

@end
