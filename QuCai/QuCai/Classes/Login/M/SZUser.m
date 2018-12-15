//
//  SZUser.m
//  ShiZhi
//
//  Created by Light on 2017/4/17.
//  Copyright © 2017年 Light. All rights reserved.
//

#import "SZUser.h"
#import <MJExtension.h>
@implementation SZUser

static SZUser * instance = nil;
/**
 归档的实现
 */
MJCodingImplementation

+ (SZUser *)shareUser {
    
    if (!instance)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[super allocWithZone:NULL] init];
            
        });
    }
    
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone {
    
    return [self shareUser];
}

- (id)copyWithZone:(NSZone *)zone {
    
    return self;
}

- (id)init {
    
    if (instance) {
        return instance;
    }
    self = [super init];
    return self;
}

- (void)saveUser {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    [userDefaults setObject:data forKey:@"user"];
    [userDefaults synchronize];
}

- (SZUser *)readUser {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
    data = [userDefaults objectForKey:@"user"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)deleteUser {
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"user"];
    [userDefaults synchronize];
}

-(void)saveBalance{
    
    [[NSUserDefaults standardUserDefaults] setObject:self.balance forKey:@"balance"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)saveBalance2:(NSString *)balance{
    
    [[NSUserDefaults standardUserDefaults] setObject:balance forKey:@"balance"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)readBalance{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *balance = [userDefaults objectForKey:@"balance"];
    return balance;
}
-(void)deleteBalance{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"balance"];
    [userDefaults synchronize];
}

+ (instancetype)userFromFile {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"user"];
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)saveLogin {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:SZHaveLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)saveExit {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:SZHaveLogin];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)saveBaseLink:(NSString *)baselink{
    
    [[NSUserDefaults standardUserDefaults] setObject:baselink forKey:@"baselink"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)readBaseLink{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *baselink = [userDefaults objectForKey:@"baselink"];
    return baselink;
}

-(void)saveH5Link:(NSString *)h5link{
    
    [[NSUserDefaults standardUserDefaults] setObject:h5link forKey:@"h5link"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)readH5Link{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *h5link = [userDefaults objectForKey:@"h5link"];
    return h5link;
}

-(void)savePlatCodeLink:(NSString *)platcodelink{
    [[NSUserDefaults standardUserDefaults] setObject:platcodelink forKey:@"platcodelink"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)readPlatCodeLink{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *platcodelink = [userDefaults objectForKey:@"platcodelink"];
    return platcodelink;
}

-(void)saveSrc1Link:(NSString *)src1link{
    [[NSUserDefaults standardUserDefaults] setObject:src1link forKey:@"src1link"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)readSrc1Link{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *src1link = [userDefaults objectForKey:@"src1link"];
    return src1link;
}

@end
