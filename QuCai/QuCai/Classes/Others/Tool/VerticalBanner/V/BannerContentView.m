//
//  bannerContentView.m
//  LYJOCDemo
//
//  Created by Liyanjun on 2017/3/10.
//  Copyright © 2017年 Liyanjun. All rights reserved.
//

#import "BannerContentView.h"

@interface BannerContentView()

@end

@implementation BannerContentView

@synthesize bannerContentViewDelegate;
@synthesize index;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        [self initialization];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if(self){
        
        [self initialization];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        
        [self initialization];
    }
    return self;
}

- (void)initialization
{
    [self addSubview:self.contentLable];
}

#pragma mark 懒加载

- (UILabel *)contentLable{

    if (!_contentLable) {
        _contentLable = [[UILabel alloc] initWithFrame:CGRectMake(10, -4, ViewWidth(self)- 8, ViewHeight(self))];
        _contentLable.textColor = [UIColor blackColor];
        _contentLable.font = TXT_SIZE_14;
    }
    return _contentLable;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:[UIApplication sharedApplication].keyWindow];
    
    if ([self.bannerContentViewDelegate respondsToSelector:@selector(didSelectedWithView:pointFromWindow:row:)]) {
        [self.bannerContentViewDelegate didSelectedWithView:self pointFromWindow:point row:index];
    }
}

@end
