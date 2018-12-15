//
//  UIColor+GExtension.h
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GExtension)

+(UIColor*)colorWithHexStr:(NSString *)hexStr;
+(UIColor*)colorWithHexStr:(NSString *)hexStr alpha:(float)alpha;

@end
