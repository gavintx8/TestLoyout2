//
//  GDataCheck.h
//  QuCai
//
//  Created by txkj_mac on 2017/6/9.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDataCheck : NSObject

+(BOOL) isValidateMobile:(NSString *)mobile;
+(BOOL) isValidateUserID:(NSString *)userID;
+ (BOOL) validateUserName:(NSString *)name;
+ (BOOL) isEmptyStr:(NSString *)str;

@end
