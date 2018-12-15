//
//  SystemInfo.h
//  hooolive
//
//  Created by garfie on 16/7/29.
//  Copyright © 2016年 junhsue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInfo : NSObject

@property BOOL isIphone4Tag;
@property BOOL isIphone5Tag;
@property BOOL isIphone6Tag;
@property BOOL isIphone6PlusTag;
@property BOOL isIphoneX;

+ (instancetype)instance;
@end
