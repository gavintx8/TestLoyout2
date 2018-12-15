//
//  NSString+HChain.m
//  TestProj
//
//  Created by dqf on 2017/8/10.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "NSString+HChain.h"

@implementation NSString (HChain)

- (NSString *(^)(NSInteger index))idx {
    return ^NSString *(NSInteger index) {
        if(index >= 0 && index < self.length) {
            return self[index];
        }
        return @"";
    };
}

- (NSString *(^)(NSInteger loc, NSInteger len))range {
    return ^NSString *(NSInteger loc, NSInteger len) {
        if(loc >= 0 && len >= 1 && loc+len <= self.length) {
            NSRange range = NSMakeRange(loc, len);
            return [self substringWithRange:range];
        }
        return @"";
    };
}

+ (NSString *(^)(NSString *format, ...))format {
    return ^NSString *(NSString *format, ...) {
        va_list arguments;
        va_start(arguments, format);
        NSString *string = [[NSString alloc] initWithFormat:format arguments:arguments];
        va_end(arguments);
        return string;
    };
}

+ (NSString *(^)(Class))fromClass {
    return ^NSString *(Class class) {
        return NSStringFromClass(class);
    };
}

- (Class(^)(void))toClass {
    return ^Class(void) {
        return NSClassFromString(self);
    };
}

+ (NSString *(^)(CGRect))fromRect {
    return ^NSString *(CGRect rect) {
        return NSStringFromCGRect(rect);
    };
}

- (CGRect(^)(void))toRect {
    return ^CGRect(void) {
        return CGRectFromString(self);
    };
}

+ (NSString *(^)(CGSize))fromSize {
    return ^NSString *(CGSize size) {
        return NSStringFromCGSize(size);
    };
}

- (CGSize(^)(void))toSize {
    return ^CGSize(void) {
        return CGSizeFromString(self);
    };
}

+ (NSString *(^)(CGPoint))fromPoint {
    return ^NSString *(CGPoint point) {
        return NSStringFromCGPoint(point);
    };
}

- (CGPoint(^)(void))toPoint {
    return ^CGPoint(void) {
        return CGPointFromString(self);
    };
}

+ (NSString *(^)(NSRange))fromRange {
    return ^NSString *(NSRange range) {
        return NSStringFromRange(range);
    };
}

- (NSRange(^)(void))toRange {
    return ^NSRange(void) {
        return NSRangeFromString(self);
    };
}

+ (NSString *(^)(SEL))fromSelector {
    return ^NSString *(SEL aSelector) {
        return NSStringFromSelector(aSelector);
    };
}

- (SEL(^)(void))toSelector {
    return ^SEL(void) {
        return NSSelectorFromString(self);
    };
}

+ (NSString *(^)(Protocol *))fromProtocol {
    return ^NSString *(Protocol *proto) {
        return NSStringFromProtocol(proto);
    };
}

- (Protocol *(^)(void))toProtocol {
    return ^Protocol *(void) {
        return NSProtocolFromString(self);
    };
}

+ (NSString *(^)(const char *))fromCString {
    return ^NSString *(const char *c) {
        return [NSString stringWithCString:c encoding:NSUTF8StringEncoding];
    };
}

- (const char *(^)(void))toCString {
    return ^const char *(void) {
        return [self cStringUsingEncoding:NSUTF8StringEncoding];
    };
}

- (NSString *(^)(NSInteger loc))fromIndex {
    return ^NSString *(NSInteger loc) {
        if(loc >= 0 && loc < self.length) {
            NSRange range = NSMakeRange(loc, self.length-loc);
            return [self substringWithRange:range];
        }
        return @"";
    };
}

- (NSString *(^)(NSInteger index))toIndex {
    return ^NSString *(NSInteger index) {
        if(index >= 0) {
            NSRange range = NSMakeRange(0, 0);
            if (index >= self.length) {
                range = NSMakeRange(0, self.length);
            }else {
                range = NSMakeRange(0, index+1);
            }
            return [self substringWithRange:range];
        }
        return @"";
    };
}

- (NSString *(^)(NSString *))fromSubString {
    return ^NSString *(NSString *org) {
        if ([self containsString:org]) {
            NSRange range = [self rangeOfString:org];
            return [self substringFromIndex:range.location+range.length];
        }
        return @"";
    };
}

- (NSString *(^)(NSString *))toSubString {
    return ^NSString *(NSString *org) {
        if ([self containsString:org]) {
            NSRange range = [self rangeOfString:org];
            return [self substringToIndex:range.location];
        }
        return @"";
    };
}

- (BOOL (^)(NSString *))contains {
    return ^BOOL (NSString *org) {
        BOOL yn = NO;
        if ([self containsString:org]) {
            yn = YES;
        }
        return yn;
    };
}

+ (NSString *(^)(id))append {
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:@"%@",obj];
    };
}

- (NSString *(^)(id))append {
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:@"%@%@", self,obj];
    };
}

- (NSString *(^)(NSString *format, ...))appendFormat {
    return ^NSString *(NSString *format, ...) {
        va_list arguments;
        va_start(arguments, format);
        NSString *string = [[NSString alloc] initWithFormat:format arguments:arguments];
        string = [NSString stringWithFormat:@"%@%@", self,string];
        va_end(arguments);
        return string;
    };
}

+ (NSString *(^)(NSString *, NSUInteger))appendCount {
    return ^NSString *(NSString *org, NSUInteger count) {
        NSMutableString *mutableStr = [[NSMutableString alloc] init];
        for (int i=0; i<count; i++) {
            [mutableStr appendString:org];
        }
        return mutableStr;
    };
}

- (NSString *(^)(NSString *, NSUInteger))appendCount {
    return ^NSString *(NSString *org, NSUInteger count) {
        NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:self];
        for (int i=0; i<count; i++) {
            [mutableStr appendString:org];
        }
        return mutableStr;
    };
}

- (NSString *(^)(NSString *, NSString *))replace {
    return ^NSString *(NSString *org1, NSString *org2) {
        return [self stringByReplacingOccurrencesOfString:org1 withString:org2];
    };
}

- (BOOL (^)(NSString *))equal {
    return ^BOOL (NSString *org) {
        return [self isEqualToString:org];
    };
}

- (BOOL (^)(Class))isClass {
    return ^BOOL (Class aClass) {
        return [self isKindOfClass:aClass];
    };
}

//空格
+ (NSString *(^)(NSUInteger))space {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@" ", count);
    };
}

- (NSString *(^)(NSUInteger))space {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@" ", count);
    };
}

//tab
+ (NSString *(^)(NSUInteger))tab {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@"\t", count);
    };
}

- (NSString *(^)(NSUInteger))tab {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@"\t", count);
    };
}

//换行
+ (NSString *(^)(NSUInteger))wrap {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@"\n", count);
    };
}

- (NSString *(^)(NSUInteger))wrap {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@"\n", count);
    };
}

- (NSArray<NSString *> *(^)(NSString *))componentsByString {
    return ^NSArray<NSString *> *(NSString *separator) {
        return [self componentsSeparatedByString:separator];
    };
}

- (NSArray<NSString *> *(^)(NSString *))componentsBySetString {
    return ^NSArray<NSString *> *(NSString *separator) {
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:separator];
        NSCharacterSet *charSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSArray *arr = [self componentsSeparatedByCharactersInSet:characterSet];
        NSMutableArray *mutablerArr = [NSMutableArray new];
        //过滤掉为空的字符串
        for (int i=0; i<arr.count; i++) {
            NSString *str = arr[i];
            if (str.length > 0) {
                //过滤掉字符串两端为空的字符
                NSString *trimStr = [str stringByTrimmingCharactersInSet:charSet];
                if (trimStr.length > 0) {
                    [mutablerArr addObject:trimStr];
                }
            }
        }
        return mutablerArr;
    };
}

- (NSArray<NSString *> *(^)(NSString *, NSString *))componentsByStringBySetString {
    return ^NSArray<NSString *> *(NSString *separator, NSString *setSeparator) {
        NSMutableArray *mutablerArr = [NSMutableArray new];
        NSArray *arr = self.componentsByString(separator);
        for (int i=0; i<arr.count; i++) {
            NSString *str = arr[i];
            NSArray *tmpArr = str.componentsBySetString(setSeparator);
            [mutablerArr addObjectsFromArray:tmpArr];
        }
        return mutablerArr;
    };
}

- (BOOL(^)(NSString *))containsString {
    return ^BOOL(NSString *org) {
        return [self containsString:org];
    };
}

- (BOOL(^)(NSArray<NSString *> *))containsStrArr {
    return ^BOOL(NSArray *arr) {
        if (arr.count <= 0) return NO;
        BOOL contain = YES;
        for (NSString *str in arr) {
            if (![self containsString:str]) {
                contain = NO;
            }
        }
        return contain;
    };
}

- (NSString *)objectAtIndexedSubscript:(NSInteger)index {
    if(index >= 0 && index < self.length) {
        NSRange range = NSMakeRange(index, 1);
        return [self substringWithRange:range];
    }
    return nil;
}

- (NSString *)objectForKeyedSubscript:(NSString *)key {
    if (key && [self containsString:key]) {
        return NSStringFromRange([self rangeOfString:key]);
    }
    return @"";
}

@end
