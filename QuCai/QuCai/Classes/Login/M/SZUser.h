//
//  SZUser.h
//  ShiZhi
//
//  Created by Light on 2017/4/17.
//  Copyright © 2017年 Light. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZUser : NSObject <NSCoding>

/** 用户名 */
@property (nonatomic, copy) NSString * nickName;

/** 头像 */
@property (nonatomic, copy) NSString * avatar;
/** 生日 */
@property (nonatomic, copy) NSString * birthday;
/** 性别 */
@property (nonatomic, copy) NSString * gender;
/** 省份 */
@property (nonatomic, copy) NSString * province;
/** 城市 */
@property (nonatomic, copy) NSString * city;
/** 地区 */
@property (nonatomic, copy) NSString * district;
/** 地址 */
@property (nonatomic, copy) NSString * address;
/** 组织 */
@property (nonatomic, copy) NSString * organization;
/** 职位名 */
@property (nonatomic, copy) NSString * position_name;
/** 信息是否完整 */
@property (nonatomic, assign) BOOL is_complete;
/** token 用户身份验证信息 */
@property (nonatomic, copy) NSString * token;
/** 本地存储 邮箱 */
@property (nonatomic, copy) NSString * user_email;



/** userKey */
@property (nonatomic, copy) NSString *userKey;
/** 用户ID */
@property (nonatomic, copy) NSString * userName;
/** balance */
@property (nonatomic, copy) NSString * balance;
@property (nonatomic, copy) NSString * integral;

/** 密码 */
@property (nonatomic, copy) NSString * password;
@property (nonatomic, copy) NSString * phonenumber;


//声明一个单例类
+ (SZUser *)shareUser;


-(void)saveUser;
- (SZUser *)readUser;
-(void)deleteUser;

-(void)saveBalance;
-(void)saveBalance2:(NSString *)balance;
- (NSString *)readBalance;
-(void)deleteBalance;

+ (instancetype)userFromFile;

//记录登录状态
- (void)saveLogin;
//记录退出状态
- (void)saveExit;


- (void)saveBaseLink:(NSString *)baselink;
- (NSString *)readBaseLink;

- (void)saveH5Link:(NSString *)h5link;
- (NSString *)readH5Link;

- (void)savePlatCodeLink:(NSString *)platcodelink;
- (NSString *)readPlatCodeLink;

- (void)saveSrc1Link:(NSString *)src1link;
- (NSString *)readSrc1Link;

@end
