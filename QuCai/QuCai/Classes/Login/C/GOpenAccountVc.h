//
//  GOpenAccountVc.h
//  QuCai
//
//  Created by txkj_mac on 2017/6/9.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBaseVc.h"
#import "GRegisterVc.h"

@interface GOpenAccountVc : GBaseVc

@property (nonatomic, strong) GRegisterVc * regVc;
@property (nonatomic, copy) NSString * navTitle;
@property (nonatomic, copy) NSString * htmlName;

@end
