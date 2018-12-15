//
//  GFooterScanView.h
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GPayScanNumber) {
    GPayScanNumber1 = 0,
    GPayScanNumber2,
    GPayScanNumber3
};

typedef void(^footerScanBlock) (NSInteger tag);

typedef void(^payNextBlock) (NSDictionary *dict);

typedef void(^DepositHelpBlock) (NSString *value);

@interface GFooterScanView : UICollectionReusableView

@property (nonatomic, assign) GPayScanNumber payNumber;
@property (nonatomic, copy) footerScanBlock clikeCall;
@property (nonatomic, copy) payNextBlock clikeNextCall;
@property (nonatomic, copy) DepositHelpBlock clikeHelpCall;

@end
