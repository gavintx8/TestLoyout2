//
//  JXCategoryIndicatorImageView.h
//  JXCategoryView
//
//  Created by jiaxin on 2017/8/17.
//  Copyright © 2017年 jiaxin. All rights reserved.
//

#import "JXCategoryIndicatorComponentView.h"

@interface JXCategoryIndicatorImageView : JXCategoryIndicatorComponentView

@property (nonatomic, strong, readonly) UIImageView *indicatorImageView;

@property (nonatomic, assign) BOOL indicatorImageViewRollEnabled;      //默认NO

@property (nonatomic, assign) CGSize indicatorImageViewSize;    //默认：CGSizeMake(30, 20)

@end
