//
//  XPFPickerView.h
//  XPFPickerViewDome
//
//  Created by www.xpf.com on 2017/11/29.
//  Copyright © 2017年 www.xpf.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XPFPickerView : UIView

/** array */
@property (nonatomic, strong) NSArray *array;
/** title */
@property (nonatomic, strong) NSString *title;

//快速创建
+ (instancetype)pickerView;

//弹出
- (void)show;


@end
