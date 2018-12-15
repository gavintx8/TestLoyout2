//
//  GTitleIconAction.m
//  QuCai
//
//  Created by tx gavin on 2017/7/7.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GTitleIconAction.h"

@implementation GTitleIconAction

+ (instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controlller tag:(NSInteger )tag{
    GTitleIconAction *titleIconAction = [[GTitleIconAction alloc]init];
    titleIconAction.title = title;
    titleIconAction.icon = image;
    titleIconAction.controller = controlller;
    titleIconAction.tag = tag;
    return titleIconAction;
}

@end
