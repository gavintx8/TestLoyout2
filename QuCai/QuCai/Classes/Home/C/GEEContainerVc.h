//
//  GEEContainerVc.h
//  QuCai
//
//  Created by tx gavin on 2017/6/26.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBaseVc.h"

typedef NS_ENUM(NSUInteger, GEEType) {
    GEETypeMG = 0,
    GEETypeHB,
    GEETypePS,
    GEETypeJDB,
    GEETypeSW
};

@interface GEEContainerVc : GBaseVc

@property (nonatomic, copy) NSString * navTitle;
@property (nonatomic, assign) GEEType geeType;

@end
