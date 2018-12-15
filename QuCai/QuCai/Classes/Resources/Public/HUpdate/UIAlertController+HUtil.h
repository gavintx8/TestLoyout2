//
//  UIAlertController+HUtil.h
//  QFProj
//
//  Created by dqf on 2017/5/31.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (HUtil)

+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
                   style:(UIAlertControllerStyle)style
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSArray *)otherButtonTitles
              completion:(void (^)(NSInteger buttonIndex))completion;

@end

