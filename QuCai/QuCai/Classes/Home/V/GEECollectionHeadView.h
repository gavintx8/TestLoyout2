//
//  GEECollectionHeadView.h
//  QuCai
//
//  Created by tx gavin on 2017/6/26.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GEECollectionHeadView : UICollectionReusableView
@property (nonatomic,strong)UILabel *titleLabel;

-(void)getSHCollectionReusableViewHearderTitle:(NSString *)title;
@end
