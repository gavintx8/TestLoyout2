//
//  main.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        if (@available(iOS 10.0, *)) {
            return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
        } else {
            // Fallback on earlier versions
        }
    }
}
