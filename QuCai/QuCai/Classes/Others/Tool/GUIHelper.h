//
//  GUIHelper.h
//  QuCai
//
//  Created by txkj_mac on 2017/5/19.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GUIHelper : NSObject
+ (UILabel *)getLabel:(UIFont *)font andTextColor:(UIColor *)color;
+ (UILabel *)getLabel:(NSString *)text andFont:(UIFont *)font andTextColor:(UIColor *)color;
+ (UILabel *)getLabel:(NSString *)text andFont:(UIFont *)font andTextColor:(UIColor *)color andAlignment:(NSTextAlignment)alignment;

+ (UIButton*) getButton:(NSString*)title titleColor:(UIColor*)titleColor;
+ (UIButton *)getButton:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedColor;
+ (UIButton*) getButton:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont *)font;

+ (UIButton*)getButtonWithImage:(UIImage *)image;
+ (UIButton*)getButtonWithImage:(UIImage *)image selectImage:(UIImage *)selectedImage;

+ (UITextField *)getTextField:(UIColor *)textColor andFont:(UIFont *)font;
+ (UITextField *)getTextField:(UIColor *)textColor andFont:(UIFont *)font andPlaceholder:(NSString *)placeholder;
+ (UITextField *)getTextField:(UIColor *)textColor andFont:(UIFont *)font andAlignment:(NSTextAlignment)alignment;
+ (UITextView  *)getTextView:(NSString *)text font:(UIFont *)font delegate:(id)delegate;

+ (UIView *)getViewWithColor:(UIColor *)color;

+ (UIImageView *)getImageViewImage:(UIImage *)image;
+ (UIImageView *)getImageView:(CGRect)rect image:(UIImage *)image;

+ (UIBarButtonItem *)getButtonItem:(UIImage *)image frame:(CGRect)frame target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)getButtonItem:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action;

@end
