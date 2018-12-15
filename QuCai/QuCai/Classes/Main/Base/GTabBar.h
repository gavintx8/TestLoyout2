//
//  GTabBar.h
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GTabBar;

@protocol GTabBarDelegate <NSObject>

- (void)tabBarPlusClick:(GTabBar *)tabBar;

@end

@interface GTabBar : UITabBar

@property (nonatomic, weak) id<GTabBarDelegate> myDelegate;
@property (nonatomic, strong) UIButton *plusBtn;

@end
