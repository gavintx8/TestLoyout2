//
//  NSString+string.h
//  hooolive
//
//  Created by garfie on 16/7/20.
//  Copyright © 2016年 junhsue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (string)

- (BOOL)linkus_isValidUID;
- (BOOL)linkus_isValidAccount;
- (BOOL)linkus_isValidPassword;
- (BOOL)linkus_isValidEmail;
- (BOOL)linkus_isValidMobile;
- (BOOL)linkus_isValidCarNumber;

@end
