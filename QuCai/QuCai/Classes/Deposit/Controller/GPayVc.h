//
//  GPayVc.h
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GPayType) {
    GPayTypeWYZF = 0,
    GPayTypeYLSM,
    GPayTypeWXZF,
    GPayTypeZFBZF,
    GPayTypeCFTZF,
    GPayTypeJDZF,
    GPayTypeSMZF,
    GPayTypeYHHK,
    GPayTypeKJZF,
    GPayTypeWXTM,
    GPayTypeZFBTM
};

@interface GPayVc : GBaseVc

/** 点击已选回调 */
@property (nonatomic , copy) void(^sureClickBlock)(NSArray *selectArray);
@property (nonatomic, assign) GPayType payType;

@end
