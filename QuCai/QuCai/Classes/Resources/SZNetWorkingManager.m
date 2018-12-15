//
//  FMNetWorkingManager.m
//  QuCai
//
//  Created by txkj_mac on 2017/5/18.
//  Copyright © 2017年 Garfie. All rights reserved.
//

#import "SZNetWorkingManager.h"

@implementation SZNetWorkingManager

// 单例
static SZNetWorkingManager *default_shareManager = nil;
+(instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
     
        if (default_shareManager == nil) {
            default_shareManager = [super manager];
        }
    });
    return default_shareManager;
}

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
                     failure:(void(^) (NSError *error))failure {
        [[SZNetWorkingManager shareManager] POST:path parameters:paramters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (success) {
            
            success(YES,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
        }
    }];
}

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
                       failure:(void(^) (NSError *error))failure  {
    
    [[SZNetWorkingManager shareManager] GET:path parameters:paramters progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgress) {
            
            downLoadProgress(downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            success(YES,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            
            failure(error);
        }
    }];
}

/**
 * 包含token的请求
 */
#pragma mark - GET OR POST (Contain Header Token)
- (void)sendHTTPDataWithBaseURL:(NSString *)baseURL andAppendURL:(NSString *)url RequestWay:(NSString *)way
                  withParamters:(NSDictionary *)parameters
                      withToken:(NSString *)token
                        success:(void(^) (BOOL isSuccess, id responseObject))success
                        failure:(void(^) (NSError *error))failure {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [sessionManager.requestSerializer setValue:[[SZUser shareUser] readH5Link] forHTTPHeaderField:@"referer"];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    
    NSString* urlPath = [baseURL stringByAppendingString:url];
    if([urlPath containsString:@"PlatformPay/onlineBanking"]){
        sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    if ([way isEqualToString:@"POST"]) {
        
        [sessionManager POST:urlPath parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            if (success) {
                success(YES, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(error);
            }
        }];
    }else if ([way isEqualToString:@"GET"]) {
        
        [sessionManager GET:urlPath parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                
                success(YES, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(error);
        }];
    }
}

#pragma mark - GET OR POST 
- (void)sendPOSTDataWithBaseURL:(NSString *)baseURL andAppendURL:(NSString *)url RequestWay:(NSString *)way
                  withParamters:(NSDictionary *)parameters
                        success:(void(^) (BOOL isSuccess, id responseObject))success
                        failure:(void(^) (NSError *error))failure {
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    NSString* urlPath = [baseURL stringByAppendingString:url];
    
    if ([way isEqualToString:@"POST"]) {
        
        [sessionManager POST:urlPath parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                
                success(YES, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            if (failure) {
                
                failure(error);
            }
        }];
    }else if ([way isEqualToString:@"GET"]) {
        
        [sessionManager GET:urlPath parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                
                success(YES, responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            failure(error);
        }];
    }
}

@end
