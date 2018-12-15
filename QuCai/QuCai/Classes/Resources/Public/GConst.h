//
//  GConst.h
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#ifndef GConst_h
#define GConst_h

#define NAVIGATION_HEIGHT 44

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define W(ww)  (ww*SCREEN_WIDTH/375)
#define H(ww)  (ww*SCREEN_WIDTH/375)

#define  KNavBarHeight      (KIsiPhoneX ? 84 : 60)
#define  KNavBarHeight2      (KIsiPhoneX ? 24 : 0)

/** 是否登录过 */
#define SZHaveLogin      @"SZHaveLogin"
#define SZH5HaveLogin      @"SZH5HaveLogin"

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define TXT_SIZE_6  [UIFont systemFontOfSize:6]
#define TXT_SIZE_8  [UIFont systemFontOfSize:8]
#define TXT_SIZE_9  [UIFont systemFontOfSize:9]
#define TXT_SIZE_10 [UIFont systemFontOfSize:10]
#define TXT_SIZE_11 [UIFont systemFontOfSize:11]
#define TXT_SIZE_12 [UIFont systemFontOfSize:12]
#define TXT_SIZE_13 [UIFont systemFontOfSize:13]
#define TXT_SIZE_14 [UIFont systemFontOfSize:14]
#define TXT_SIZE_15 [UIFont systemFontOfSize:15]
#define TXT_SIZE_16 [UIFont systemFontOfSize:16]
#define TXT_SIZE_17 [UIFont systemFontOfSize:17]
#define TXT_SIZE_18 [UIFont systemFontOfSize:18]
#define TXT_SIZE_20 [UIFont systemFontOfSize:20]
#define TXT_SIZE_21 [UIFont systemFontOfSize:21]
#define TXT_SIZE_22 [UIFont systemFontOfSize:22]
#define TXT_SIZE_24 [UIFont systemFontOfSize:24]
#define TXT_SIZE_28 [UIFont systemFontOfSize:28]
#define TXT_SIZE_30 [UIFont systemFontOfSize:30]
#define TXT_SIZE_32 [UIFont systemFontOfSize:32]
#define TXT_SIZE_50 [UIFont systemFontOfSize:50]


#define NAVIGATION_TITLE @"天下网络"

#define TABBAR_HOMEPAGE @"首页"
#define TABBAR_CATEGORY @"分类"
#define TABBAR_SERVICE @"客服"
#define TABBAR_PURCHASE @"存款"
#define TABBAR_VIPCENTER @"会员中心"
#define TABBAR_LOGIN @"登录"

#define TABBAR_HOMEPAGE_ICON @"di_index"
#define TABBAR_HOMEPAGE_ICONH @"di_index_h"

#define TABBAR_HOMEPAGE_CATEGORY @"di_more"
#define TABBAR_HOMEPAGE_CATEGORYH @"di_more_h"

#define TABBAR_PURCHASE_ICON @"di_zhuce"
#define TABBAR_PURCHASE_ICONH @"di_zhuce"


#define TABBAR_SERVICE_ICON @"di_kf"
#define TABBAR_SERVICE_ICONH @"di_kf_h"

#define TABBAR_VIPCENTER_ICON @"di_login"
#define TABBAR_VIPCENTER_ICONH @"di_login_h"

#define kNetError @"请求失败！！！"

#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR16Font [UIFont fontWithName:PFR size:16];

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define AnimatorDuration  0.25

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define KEYWINDOW  [UIApplication sharedApplication].keyWindow
/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

#define MAIN_COLOR  [UIColor colorWithRed:0.25 green:0.7 blue:0.54 alpha:1]

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kSize(a)        ceil((a)*([UIScreen mainScreen].bounds.size.width/375.0))

#endif /* GConst_h */
