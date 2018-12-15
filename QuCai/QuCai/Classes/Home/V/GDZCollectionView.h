//
//  GDZCollectionView.h
//  QuCai
//
//  Created by mac on 2017/10/21.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXPageListView.h"

typedef void(^GDZCollectionViewBlock)(NSInteger index);

@interface GDZCollectionView : UIView < JXPageListViewListDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceImg;
@property (nonatomic, strong) NSMutableArray <NSString *> *dataSourceTitle;
@property (nonatomic, copy) GDZCollectionViewBlock dzBlock;

@end
