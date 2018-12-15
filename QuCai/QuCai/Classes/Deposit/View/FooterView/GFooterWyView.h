//
//  DCFooterReusableView.h
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GPayNumber) {
    GPayNumber1 = 0,
    GPayNumber2,
    GPayNumber3,
    GPayNumber4,
    GPayNumber5,
    GPayNumber6,
    GPayNumber7,
    GPayNumber8,
    GPayNumber9,
    GPayNumber10,
    GPayNumber11,
    GPayNumber12,
    GPayNumber13,
    GPayNumber14,
    GPayNumber15,
    GPayNumber16,
    GPayNumber17,
    GPayNumber18,
    GPayNumber19,
    GPayNumber20,
    GPayNumber21
};

typedef void(^footerWyBlock) (NSInteger tag);

typedef void(^payNextBlock) (NSDictionary *dict);

typedef void(^DepositHelpBlock) (NSString *value);

@interface GFooterWyView : UICollectionReusableView

@property (nonatomic, assign) GPayNumber payNumber;
@property (nonatomic, copy) footerWyBlock clikeCall;
@property (nonatomic, copy) payNextBlock clikeNextCall;
@property (nonatomic, copy) DepositHelpBlock clikeHelpCall;

@property (nonatomic, strong) NSArray *typeList;

- (void)updateTypeList:(NSArray *)typeList and:(NSString *)type and:(NSString *)cate;

@end
