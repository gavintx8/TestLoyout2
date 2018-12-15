//
//  UIView+SZExtension.h
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIView (SZExtension)

@property (nonatomic, assign) CGSize sz_size;
@property (nonatomic, assign) CGFloat sz_width;
@property (nonatomic, assign) CGFloat sz_height;
@property (nonatomic, assign) CGFloat sz_x;
@property (nonatomic, assign) CGFloat sz_y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


/** 控件最左边那根线的位置(minX的位置) */
@property (nonatomic, assign) CGFloat left;
/** 控件最右边那根线的位置(maxX的位置) */
@property (nonatomic, assign) CGFloat right;
/** 控件最顶部那根线的位置(minY的位置) */
//@property (nonatomic, assign) CGFloat top;
/** 控件最底部那根线的位置(maxY的位置) */
@property (nonatomic, assign) CGFloat bottom;

@end
