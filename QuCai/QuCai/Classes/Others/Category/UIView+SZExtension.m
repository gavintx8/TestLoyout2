//
//  UIView+SZExtension.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//
#import "UIView+SZExtension.h"

@implementation UIView (SZExtension)

-(void)setSz_size:(CGSize)sz_size
{
    CGRect frame = self.frame;
    frame.size = sz_size;
    self.frame = frame;
}

-(CGSize)sz_size
{
    return self.frame.size;
}

- (void)setSz_width:(CGFloat)sz_width
{
    CGRect frame = self.frame;
    frame.size.width = sz_width;
    self.frame = frame;
}

-(CGFloat)sz_width
{
    return self.frame.size.width;
}

- (void)setSz_height:(CGFloat)sz_height
{
    CGRect frame = self.frame;
    frame.size.height = sz_height;
    self.frame = frame;
}

-(CGFloat)sz_height
{
    return self.frame.size.height;
}

- (void)setSz_x:(CGFloat)sz_x
{
    CGRect frame = self.frame;
    frame.origin.x = sz_x;
    self.frame = frame;
}

-(CGFloat)sz_x
{
    return self.frame.origin.x;
}

- (void)setSz_y:(CGFloat)sz_y
{
    CGRect frame = self.frame;
    frame.origin.y = sz_y;
    self.frame = frame;
}

-(CGFloat)sz_y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setLeft:(CGFloat)left
{
    self.sz_x = left;
}

- (CGFloat)left
{
    return self.sz_x;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return CGRectGetMaxY(self.frame);
}

@end
