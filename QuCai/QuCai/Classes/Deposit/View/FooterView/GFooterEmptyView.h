//
//  GFooterEmptyView.h
//  QuCai
//
//  Created by mac on 2017/7/25.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^footerScanBlock) (NSInteger tag);

@interface GFooterEmptyView : UICollectionReusableView

@property (nonatomic, copy) footerScanBlock clikeCall;

@end
