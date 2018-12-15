//
//  GFundHeadView.h
//  QuCai
//
//  Created by mac on 2017/7/14.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClikedFundCallback) (NSInteger tag);
typedef void(^ClikedQuotaCallback) (NSInteger tag);

@interface GFundHeadView : UIView

@property(nonatomic,strong)UILabel *fundLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, copy) ClikedFundCallback clikeCall;
@property (nonatomic, copy) ClikedQuotaCallback clikeCall2;

@end
