//
//  GLotterysegmentVc.h
//  QuCai
//
//  Created by txkj_mac on 2017/6/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBaseVc.h"

typedef NS_ENUM(NSUInteger, GLotteryType) {
    GLotteryTypeNew = 0,
    GLotteryTypeNormal,
    GLotteryTypeVR,
    GLotteryTypeGY
};

@interface GLotterysegmentVc : GBaseVc
@property (nonatomic, assign) GLotteryType lotteryType;

@end
