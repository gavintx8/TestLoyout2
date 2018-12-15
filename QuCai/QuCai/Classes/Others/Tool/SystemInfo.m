//
//  SystemInfo.m
//  hooolive
//
//  Created by garfie on 16/7/29.
//  Copyright © 2016年 junhsue. All rights reserved.
//

#import "SystemInfo.h"

@implementation SystemInfo

+ (instancetype)instance {

    static SystemInfo *sysInfo = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sysInfo = [[self alloc] init];
    });
    
    return sysInfo;
}

- (instancetype)init {

    CGRect rect = [UIScreen mainScreen].bounds;
    if (rect.size.height == 480) {
        self.isIphone4Tag = YES;
    } else if (rect.size.height == 568) {
        self.isIphone5Tag = YES;
    } else if (rect.size.height == 667) {
        self.isIphone6Tag = YES;
    } else if (rect.size.height == 736) {
        self.isIphone6PlusTag = YES;
    } else if (rect.size.height == 812) {
        self.isIphoneX = YES;
    }
    return self;
}

@end
