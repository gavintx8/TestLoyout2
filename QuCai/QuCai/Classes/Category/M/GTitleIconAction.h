//
//  GTitleIconAction.h
//  QuCai
//
//  Created by tx gavin on 2017/7/7.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTitleIconAction : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, assign) NSInteger tag;

+ (instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controlller tag:(NSInteger )tag;

@end
