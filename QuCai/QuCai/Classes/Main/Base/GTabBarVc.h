//
//  GTabBarVc.h
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTabBar.h"
#import "GVIPCenterVc.h"

@interface GTabBarVc : UITabBarController<UITabBarControllerDelegate, UITabBarDelegate>

@property (nonatomic, strong) GTabBar *gTabBar;
@property (nonatomic, strong) GVIPCenterVc *vipVc;

@end
