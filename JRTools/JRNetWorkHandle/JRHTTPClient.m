//
//  JRHTTPClient.m
//  JRKits
//
//  Created by jackfrow on 2018/4/11.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRHTTPClient.h"
#import <AFNetworkActivityIndicatorManager.h>
#import <AFHTTPSessionManager.h>

NSString *const JRHTTPClientErrorDomain = @"com.jr.http.error";

@interface JRHTTPClient()

@property (nonatomic,readwrite,assign) JRNetworkStatus networkStatus;

@end

//当前网络状态
static JRNetworkStatus networkStatus;
// 默认超时时间
#define JR_REQUEST_TIMEOUT 20.f

@implementation JRHTTPClient

+(instancetype)sharedClient{
    
    static dispatch_once_t once;
    static JRHTTPClient *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[self alloc]init];
        __singleton__.requestTimeout = JR_REQUEST_TIMEOUT;
    });
    return __singleton__;
    
}

#pragma SESSION管理设置
- (AFHTTPSessionManager *)manager {
    
      //开启网络检测
      [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
      AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**
     *  默认请求和返回的数据类型
     */
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];//请求配置
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//响应结果配置
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;//编码方式
    // 将token加到http头里
    if ([JRHTTPClient sharedClient].baseToken.length) {
        [manager.requestSerializer setValue:[JRHTTPClient sharedClient].baseToken forHTTPHeaderField:@"token"];
    }
    /**
     *  取出NULL值
     */
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    
    //设置可接受数据的类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"image/*"]];
    
    //设置请求超时时间
    manager.requestSerializer.timeoutInterval = [JRHTTPClient sharedClient].requestTimeout;
    //检测网络状态
    [self detectNetworkStaus];
    
    return manager;
}


/**
 检测网络状态
 */
- (void)detectNetworkStaus {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //在这里可以定义网络状态切换的提示
        if (status == AFNetworkReachabilityStatusNotReachable){//无网络连接
            networkStatus = JRNetworkStatusNotReachable;
        }else if (status == AFNetworkReachabilityStatusUnknown){//未知网络
            networkStatus = JRNetworkStatusUnknown;
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){//流量
            networkStatus = JRNetworkStatusWWAN;
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){//WIFI
            networkStatus = JRNetworkStatusWIFI;
        }
    }];
}


-(BOOL)isAvaiableWithResponse:(NSDictionary *)responseObject{
    
    BOOL availabel = responseObject && [responseObject[@"ok"] boolValue];
//    if (responseObject[@"servertime"]) {//服务器时间
//        NSDate *standardDate = [NSDate dateWithTimeIntervalSince1970:[responseObject[@"servertime"] integerValue]];
//        [NSDate setStandardDate:standardDate currentDate:[NSDate date]];
//    }
    return availabel;
    
}


#pragma mark - API

+ (NSError *)errorWithResponse:(NSDictionary *)response
{
    NSError *error = nil;
    NSString *errorDescription = response[@"error"];
    NSInteger code = [response[@"errorcode"] integerValue];
    BOOL ok = [response[@"ok"] boolValue];
    if (!ok) {
        NSDictionary *userInfo = @{@"description": errorDescription ?: @"未知错误"};
        error = [NSError errorWithDomain:JRHTTPClientErrorDomain code:code userInfo:userInfo];
    }
    return error;
}

-(NSURLSessionTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    __weak typeof(self) weakSelf = self;
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    return   [[self manager] POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //不需要实现
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        BOOL available = [weakSelf isAvaiableWithResponse:responseObject];
        if (success && available) {
            success(task, responseObject);
        }
        else if (!available) {
            failure(task, [weakSelf.class errorWithResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        
        if (failure) {
            failure(task, error);
        }
    
    }];
    
}

-(NSURLSessionTask *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    __weak typeof(self) weakSelf = self;
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    return   [[self manager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        BOOL available = [weakSelf isAvaiableWithResponse:responseObject];
        if (success && available) {
            success(task, responseObject);
        }
        else if (!available) {
            failure(task, [weakSelf.class errorWithResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure) {
            failure(task, error);
        }
        
    }];
    
}

-(NSURLSessionTask *)uploadWithImageArray:(NSMutableArray *)imageArray url:(NSString *)url params:(NSDictionary *)params showHUD:(BOOL)showHUD progressBlock:(JRHTTPClientSuccessBlock)progressBlock successBlock:(JRHTTPClientProgressBlock)successBlock failBlock:(JRHTTPClientFailureBlock)failBlock{
    
    return [[self manager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }] ;
    
    
}



@end
