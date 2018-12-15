//
//  GHandleView.m
//  QuCai
//
//  Created by tx gavin on 2017/7/8.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GHandleView.h"
#import "GTitleIconView.h"

@interface GHandleView ()
@property (nonatomic, strong) NSArray *mens;
@end

@implementation GHandleView
{
    HandleBlock _handleBlock;
}

static const NSInteger DefaultRowNumbers = 3;

- (instancetype)initMenu:(NSArray <GTitleIconAction *>*)mens handleBlock:(void (^)(NSInteger))handleBlock WithLine:(BOOL)line{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        if (handleBlock) {
            _handleBlock = handleBlock;
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
    if (_handleBlock) {
        _handleBlock(gesture.view.tag);
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
