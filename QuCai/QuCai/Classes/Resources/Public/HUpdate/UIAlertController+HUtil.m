//
//  UIAlertController+HUtil.m
//  QFProj
//
//  Created by dqf on 2017/5/31.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "UIAlertController+HUtil.h"
#import <objc/runtime.h>

static const int alert_action_key;

@implementation UIAlertController (HUtil)

+ (id)showAlertWithTitle:(NSString *)title
                 message:(NSString *)message
                   style:(UIAlertControllerStyle)style
       cancelButtonTitle:(NSString *)cancelButtonTitle
       otherButtonTitles:(NSArray *)otherButtonTitles
              completion:(void (^)(NSInteger buttonIndex))completion {
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
        
        if (cancelButtonTitle) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                                   style:UIAlertActionStyleCancel
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     if (completion) {
                                                                         completion(0);
                                                                     }
                                                                 }];
            [alertController addAction:cancelAction];
        }
        
        if (otherButtonTitles.count > 0) {
            for (int i = 0; i < otherButtonTitles.count; i++) {
                UIAlertAction *action = [UIAlertAction actionWithTitle:otherButtonTitles[i]
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * _Nonnull action) {
                                                                   if (completion) {
                                                                       NSNumber *index = objc_getAssociatedObject(action, &alert_action_key);
                                                                       completion([index integerValue]);
                                                                   }
                                                               }];
                objc_setAssociatedObject(action, &alert_action_key, @(i + 1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [alertController addAction:action];
            }
        }
        UIViewController *rootController = [UIApplication sharedApplication].delegate.window.rootViewController;
        [rootController presentViewController:alertController animated:YES completion:nil];
        return alertController;
    } else {
        /*
         UIAlertView *alert = [[UIAlertView alloc] init];
         alert.title = title;
         alert.message = message;
         if (cancelButtonTitle) {
         [alert addButtonWithTitle:cancelButtonTitle];
         }
         if (otherButtonTitles.count > 0) {
         for (int i = 0; i < otherButtonTitles.count; i++) {
         [alert addButtonWithTitle:otherButtonTitles[i]];
         }
         }
         [alert setCancelButtonIndex:0];
         [alert showWithCompletionBlock:completion];
         return alert;*/
        return nil;
    }
}

@end

