//
//  UIColor+GExtension.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "UIColor+GExtension.h"

@implementation UIColor (GExtension)

+(UIColor*)colorWithHexStr:(NSString *)hexStr {
    return [self colorWithHexStr:hexStr alpha:1.0];
}

+(UIColor*)colorWithHexStr:(NSString *)hexStr alpha:(float)alpha {
    uint value;
    hexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
    
    if (hexStr) {
        [[NSScanner scannerWithString:hexStr] scanHexInt:&value];
        return [self colorWithHex:value alpha:alpha];
    } else {
        return [self blackColor];
    }
}

+(UIColor*)colorWithHex:(uint)value alpha:(float)alpha {
    return [self colorWithRed:((float)((value & 0xFF0000) >> 16)) / 255.0
                        green:((float)((value & 0xFF00) >> 8)) / 255.0
                         blue:((float)(value & 0xFF)) / 255.0
                        alpha:alpha];
}
@end
