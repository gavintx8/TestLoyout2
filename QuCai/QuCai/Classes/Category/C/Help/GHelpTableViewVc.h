//
//  GHelpTableViewVc.h
//  QuCai
//
//  Created by tx gavin on 2017/7/7.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GHelpType) {
    GHelpTypeHot = 0,
    GHelpTypeLogin,
    GHelpTypeDeposit,
    GHelpTypeDrawn,
    GHelpTypeTransfer,
    GHelpTypeAccount,
    GHelpTypeMember,
    GHelpTypeBank,
    GHelpTypeOther
};

@interface GHelpTableViewVc : GBaseVc

@property (nonatomic, copy) NSString * navTitle;
@property (nonatomic, assign) GHelpType helpType;

@end
