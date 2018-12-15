//
//  GPaySuccessVc.h
//  QuCai
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBaseVc.h"

@interface GPaySuccessVc : GBaseVc

@property (nonatomic, strong) NSString *ref_id;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic , strong) NSDictionary *bankDict;

@end
