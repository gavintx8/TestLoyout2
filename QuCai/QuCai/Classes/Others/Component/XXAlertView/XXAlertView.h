//
//  WDAlertView.h
//  IOS-WeidaiCreditLoan
//
//  Created by yaoqi on 16/3/25.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XXAlertView : UIView

/**
 *  确定按钮的点击事件
 */
@property (nonatomic, copy) void (^sureButtonTapped)(void);

+ (instancetype)sharedAlertView;

/**
 *  显示弹出框
 *
 *  @param textString 弹出框文字说明
 */
- (void)showAlertViewWithTextString:(NSString *)textString andType:(NSInteger)type;

@end
