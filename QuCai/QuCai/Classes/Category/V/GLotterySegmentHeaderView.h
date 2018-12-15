//
//  GLotterySegmentHeaderView.h
//  QuCai
//
//  Created by txkj_mac on 2017/6/13.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLotterySegmentHeaderView : UICollectionReusableView
@property (nonatomic,strong)UILabel *titleLabel;

-(void)getSHCollectionReusableViewHearderTitle:(NSString *)title;
@end
