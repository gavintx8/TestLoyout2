//
//  GUIHelper.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/19.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GUIHelper.h"

@implementation GUIHelper
#pragma mark UILabel
+ (UILabel *)getLabel:(NSString *)text andFont:(UIFont *)font andTextColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = font;
    label.textColor = color;
    return label;
}
+ (UILabel *)getLabel:(UIFont *)font andTextColor:(UIColor *)color
{
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    return label;
}

+ (UILabel *)getLabel:(NSString *)text andFont:(UIFont *)font andTextColor:(UIColor *)color andAlignment:(NSTextAlignment)alignment
{
    UILabel *label = [GUIHelper getLabel:text andFont:font andTextColor:color];
    label.textAlignment = alignment;
    return label;
}

#pragma mark UIButton
+ (UIButton*)getButton:(NSString*)title titleColor:(UIColor*)titleColor
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton *)getButton:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedColor
{
    UIButton *button = [GUIHelper getButton:title titleColor:titleColor];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    return button;
}

+ (UIButton*)getButton:(NSString*)title titleColor:(UIColor*)titleColor font:(UIFont *)font
{
    UIButton *button = [GUIHelper getButton:title titleColor:titleColor];
    button.titleLabel.font = font;
    
    return button;
}

+ (UIButton*)getButtonWithImage:(UIImage *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    
    return button;
}

+ (UIButton*)getButtonWithImage:(UIImage *)image selectImage:(UIImage *)selectedImage
{
    UIButton *button = [GUIHelper getButtonWithImage:image];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    return button;
}


#pragma mark UITextField TextView
+ (UITextField *)getTextField:(UIColor *)textColor andFont:(UIFont *)font
{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = font;
    textField.textColor = textColor;
    return textField;
}

+ (UITextField *)getTextField:(UIColor *)textColor andFont:(UIFont *)font andPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [GUIHelper getTextField:textColor andFont:font];
    textField.placeholder = placeholder;
    return textField;
}

+ (UITextField *)getTextField:(UIColor *)textColor andFont:(UIFont *)font andAlignment:(NSTextAlignment)alignment
{
    UITextField *textField = [GUIHelper getTextField:textColor andFont:font];
    textField.textAlignment = alignment;
    return textField;
}

+ (UITextView *)getTextView:(NSString *)text font:(UIFont *)font delegate:(id)delegate
{
    UITextView *textView = [[UITextView alloc]init];
//    textView.placeholder = @"输入您想合成的鬼畜视频";
    textView.delegate = delegate;
    textView.backgroundColor = [UIColor clearColor];
    textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    return textView;
}

#pragma mark UIView ImageView
+ (UIView *)getViewWithColor:(UIColor *)color
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = color;
    return view;
}

+ (UIImageView *)getImageView:(CGRect)frame image:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = image;
    return imageView;
}

+ (UIImageView *)getImageViewImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = image;
    return imageView;
}

+ (UIBarButtonItem *)getButtonItem:(UIImage *)image frame:(CGRect)frame target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)getButtonItem:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font =  TXT_SIZE_17;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
