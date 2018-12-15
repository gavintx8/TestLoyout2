//
//  JXCategoryFactory.h
//  JXCategoryView
//
//  Created by jiaxin on 2017/8/17.
//  Copyright © 2017年 jiaxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JXCategoryFactory : NSObject

+ (CGFloat)interpolationFrom:(CGFloat)from to:(CGFloat)to percent:(CGFloat)percent;

+ (UIColor *)interpolationColorFrom:(UIColor *)fromColor to:(UIColor *)toColor percent:(CGFloat)percent;

@end
