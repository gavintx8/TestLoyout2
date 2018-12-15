//
//  JMBaseButton.h
//  JMButton
//
//  Created by JM on 2017/1/10.
//  Copyright © 2017年 JM. All rights reserved.
//
/*
 .----------------. .----------------.
 | .--------------. | .--------------. |
 | |     _____    | | | ____    ____ | |
 | |    |_   _|   | | ||_   \  /   _|| |
 | |      | |     | | |  |   \/   |  | |
 | |   _  | |     | | |  | |\  /| |  | |
 | |  | |_' |     | | | _| |_\/_| |_ | |
 | |  `.___.'     | | ||_____||_____|| |
 | |              | | |              | |
 | '--------------' | '--------------' |
 '----------------' '----------------'
 github: https://github.com/JunAILiang
 blog: https://www.ljmvip.cn
 */

#import <UIKit/UIKit.h>
#import "JMBaseButtonConfig.h"

@interface JMBaseButton : UIButton

+ (instancetype)buttonFrame:(CGRect)frame ButtonConfig:(JMBaseButtonConfig *)buttonConfig;

- (instancetype)initWithFrame:(CGRect)frame ButtonConfig:(JMBaseButtonConfig *)buttonConfig;

@end
