//
//  GFooterBankHkView.h
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^footerBankHkBlock) (NSInteger tag);

typedef void(^PayNextBlock) (NSString *ref_id,NSString *amount);

typedef void(^DepositHelpBlock) (NSString *value);

@interface GFooterBankHkView : UICollectionReusableView

@property (nonatomic, copy) footerBankHkBlock clikeCall;
@property (nonatomic, copy) PayNextBlock clikeNextCall;
@property (nonatomic, copy) DepositHelpBlock clikeHelpCall;

@end
