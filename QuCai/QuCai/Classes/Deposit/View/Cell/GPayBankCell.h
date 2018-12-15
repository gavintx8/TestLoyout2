//
//  GAttributeItemCell.h
//  QuCai
//
//  Created by mac on 2017/7/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FLAnimatedImageView+WebCache.h>

@class GPayBankItem;
@interface GPayBankCell : UICollectionViewCell

/* 内容 */
@property (strong , nonatomic)GPayBankItem *contentItem;
@property (strong , nonatomic)FLAnimatedImageView *iv;

@end
