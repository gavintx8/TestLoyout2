//
//  GTransferAccounts.h
//  QuCai
//
//  Created by txkj_mac on 2017/6/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GBaseVc.h"

@interface GTransferAccounts : GBaseVc
@property (nonatomic, assign) NSInteger leftindex;
@property (nonatomic, copy) NSString *platformName;
@property (nonatomic, copy) NSString *fromName;
@property (nonatomic, copy) NSString *gameType;
@property (nonatomic, copy) NSString *gameID;
@property (nonatomic, copy) NSString *transferType;
@end
