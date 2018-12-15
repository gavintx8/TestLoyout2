//
//  NSString+string.m
//  hooolive
//
//  Created by garfie on 16/7/20.
//  Copyright © 2016年 junhsue. All rights reserved.
//

#import "NSString+string.h"

@implementation NSString (string)

- (BOOL)linkus_isValidUID
{
    NSString* regex = @"^[2-9][0-9]{4,9}";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)linkus_isValidAccount
{
    NSString* regex = @"^[a-zA-Z]\\w{5,15}$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)linkus_isValidPassword
{
    NSString* regex = @"^[a-zA-Z0-9*&@]{6,12}+$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)linkus_isValidEmail
{
    NSString* regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)linkus_isValidMobile
{
    NSString* regex = @"^1[3|4|5|7|8][0-9]{9}";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)linkus_isValidCarNumber
{
    NSString* regex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}
@end
