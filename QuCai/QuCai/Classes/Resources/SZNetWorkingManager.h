//
//  FMNetWorkingManager.h
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface SZNetWorkingManager : AFHTTPSessionManager

+ (instancetype)shareManager;

#pragma mark - POST 传送网络数据
/**
 *  传送网络数据
 *
 *  @param path           请求的地址
 *  @param paramters      请求的参数
 *  @param upLoadProgress 进度
 *  @param success        请求成功的回调
 *  @param failure        请求失败的回调
 */
- (void)sendPOSTDataWithPath:(NSString *)path
               withParamters:(NSDictionary *)paramters
                withProgress:(void(^) (float progress))upLoadProgress
                     success:(void(^) (BOOL isSuccess, id responseObject))success
                     failure:(void(^) (NSError *error))failure ;

#pragma mark - GET 请求网络数据
/**
 *  请求网络数据
 *
 *  @param path             请求的地址
 *  @param paramters        请求的参数
 *  @param downLoadProgress 进度
 *  @param success          请求成功的回调
 *  @param failure          请求失败的回调
 */
- (void)requestGETDataWithPath:(NSString *)path
                 withParamters:(NSDictionary *)paramters
                  withProgress:(void(^) (float progress))downLoadProgress
                       success:(void(^) (BOOL isSuccess, id responseObject))success
                       failure:(void(^) (NSError *error))failure ;

#pragma mark - GET OR POST (Contain Header Token)
/**
 *  @param baseURL     请求base url
 *  @param url              请求url
 *  @param way             GET OR POST
 *  @param token           Header token
 *  @param success        请求成功的回调
 *  @param failure           请求失败的回调
 */
- (void)sendHTTPDataWithBaseURL:(NSString *)baseURL andAppendURL:(NSString *)url RequestWay:(NSString *)way
               withParamters:(NSDictionary *)parameters
               withToken:(NSString *)token
                     success:(void(^) (BOOL isSuccess, id responseObject))success
                     failure:(void(^) (NSError *error))failure;

#pragma mark - GET OR POST
/**
 *  @param baseURL     请求base url
 *  @param url              请求url
 *  @param way             GET OR POST
 *  @param success        请求成功的回调
 *  @param failure           请求失败的回调
 */
- (void)sendPOSTDataWithBaseURL:(NSString *)baseURL andAppendURL:(NSString *)url RequestWay:(NSString *)way
                  withParamters:(NSDictionary *)parameters
                        success:(void(^) (BOOL isSuccess, id responseObject))success
                        failure:(void(^) (NSError *error))failure;
@end
