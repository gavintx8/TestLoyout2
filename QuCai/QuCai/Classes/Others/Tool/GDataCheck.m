//
//  GDataCheck.m
//  QuCai
//
//  Created by txkj_mac on 2017/6/9.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "GDataCheck.h"

@implementation GDataCheck

+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{5,11}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

//是否是空字符串
+ (BOOL)isEmptyStr:(NSString *)str {
    if (str == nil || [str isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (BOOL) isValidateUserID:(NSString *)userID {
    if (userID == nil || [userID isEqualToString:@""] || userID == NULL || [userID isKindOfClass:[NSNull class]] || (userID.length == 0)) {
        return NO;
    } else {
        return YES;
    }
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    /*
     18321302235
     NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|7[6-8])\\d{8}$";
     NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|7[8])\\d)\\d{7}$";
     NSString * CU = @"^1(3[0-2]|5[256]|8[56]|7[6])\\d{8}$";
     NSString * CT = @"^1((33|53|8[09])[0-9]|349|7[7])\\d{7}$";
     */
    //    //手机号以13， 15，17，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    return [phoneTest evaluateWithObject:mobile];
    NSString * MOBILE = @"^1(3|5|8|7)\\d{9}$";
    //    /**
    //     10         * 中国移动：China Mobile
    //     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,  178
    //     12         */
    //    NSString * CM = @"^1(3|5|8|7)\\d{9}$";
    //    /**
    //     15         * 中国联通：China Unicom
    //     16         * 130,131,132,152,155,156,185,186,  176
    //     17         */
    //    NSString * CU = @"^1(3|5|8|7)\\d{9}$";
    //    /**
    //     20         * 中国电信：China Telecom
    //     21         * 133,1349,153,180,189,  177
    //     22         */
    //    NSString * CT = @"^1(3|5|8|7)\\d{9}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    //    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    //    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestmobile evaluateWithObject:mobile])
        //        || ([regextestcm evaluateWithObject:mobile] == YES)
        //        || ([regextestct evaluateWithObject:mobile] == YES)
        //        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
@end
