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
#import "JRUploadData.h"
#import <SVProgressHUD.h>
#import "DSToast.h"

NSString *const JRHTTPClientErrorDomain = @"com.jr.http.error";

NSString* const JR_ERROR_COMMON  = @"网络出现错误，请检查网络连接";

// 网络错误Log打印
#define JR_ERROR [NSError errorWithDomain:JRHTTPClientErrorDomain code:-999 userInfo:@{ NSLocalizedDescriptionKey:JR_ERROR_COMMON}]

@interface JRHTTPClient()


@end



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
    
    [manager.requestSerializer setValue:@"ae728a37e13f6f71f1c85e8f82d31c61" forHTTPHeaderField:@"API-User-Token"];
    
    if ([JRHTTPClient sharedClient].baseToken.length) {
        [manager.requestSerializer setValue:[JRHTTPClient sharedClient].baseToken forHTTPHeaderField:@"token"];
    }
    /**
     *  取出NULL值
     */
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    
//    设置可接受数据的类型
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
//    [self detectNetworkStaus];
    
    return manager;
}


/**
 检测网络状态
 */
- (void)detectNetworkStaus {
//    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
//    [reachabilityManager startMonitoring];
//    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        //在这里可以定义网络状态切换的提示
//        if (status == AFNetworkReachabilityStatusNotReachable){//无网络连接
//            _networkStatus = JRNetworkStatusNotReachable;
//        }else if (status == AFNetworkReachabilityStatusUnknown){//未知网络
//            _networkStatus = JRNetworkStatusUnknown;
//        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){//流量
//            _networkStatus = JRNetworkStatusWWAN;
//        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){//WIFI
//            _networkStatus = JRNetworkStatusWIFI;
//        }
//    }];
}


-(BOOL)isAvaiableWithResponse:(NSDictionary *)responseObject{
    
    BOOL availabel = responseObject && [responseObject[@"error"] intValue] == 0;
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
        NSDictionary *userInfo = @{@"description": errorDescription ?: @"网络错误"};
        error = [NSError errorWithDomain:JRHTTPClientErrorDomain code:code userInfo:userInfo];
    }
    return error;
}

-(NSURLSessionTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    // 请求前先判断是否有网络
    if (_networkStatus == JRNetworkStatusUnknown ||  _networkStatus == JRNetworkStatusNotReachable) {
        failure ? failure(nil,JR_ERROR) : nil;
        return nil;
    }
    
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
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        
        if (failure) {
            failure(task, error);
        }
    
    }];
    
}

-(NSURLSessionTask *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{
    
    // 请求前先判断是否有网络
    if (_networkStatus == JRNetworkStatusUnknown ||  _networkStatus == JRNetworkStatusNotReachable) {
        failure ? failure(nil,JR_ERROR) : nil;
        return nil;
    }
    
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
        
    } failure:^(NSURLSessionDataTask *  task, NSError *  error) {
        
        if (failure) {
            failure(task, error);
        }
        
    }];
    
}

-(NSURLSessionTask *)uploadWithImageArray:(NSMutableArray *)imageArray url:(NSString *)url params:(NSDictionary *)params showHUD:(BOOL)showHUD progressBlock:(JRHTTPClientProgressBlock)progressBlock successBlock:(JRHTTPClientSuccessBlock)successBlock failBlock:(JRHTTPClientFailureBlock)failBlock{
    
    // 请求前先判断是否有网络
    if (_networkStatus == JRNetworkStatusUnknown ||  _networkStatus == JRNetworkStatusNotReachable) {
        failBlock ? failBlock(JR_ERROR) : nil;
        return nil;
    }
    
     __weak typeof(self) weakSelf = self;
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    return [[self manager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 判断是否有图片数据
        if (!imageArray.count) {
            NSLog(@"图片数组为空");
        }
        // 循环添加数据
        for (id _Nullable uploadFile in imageArray) {
            if ([uploadFile isKindOfClass:[JRUploadData class]]) {
                
                JRUploadData *uploadParam = (JRUploadData *)uploadFile;
                [formData appendPartWithFileData:uploadParam.data name:uploadParam.paramKey
                                        fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
            }else{
                NSLog(@"文件数组不是TLUploadParam对象，请检查文件数组类型");
                return;
            }
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (showHUD) {
                [SVProgressHUD showProgress:uploadProgress.fractionCompleted];
            }
        });
        
      
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        BOOL available = [weakSelf isAvaiableWithResponse:responseObject];
        if (successBlock && available) {
            successBlock(responseObject);
        }
        else if (!available) {
            failBlock([weakSelf.class errorWithResponse:responseObject]);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        if (failBlock) {
            failBlock(error);
        }
        
    }] ;
    
    
}

-(NSURLSessionTask *)uploadFileWithUrl:(NSString *)url uploadingFile:(NSString *)uploadingFile showHUD:(BOOL)showHUD progressBlock:(JRHTTPClientProgressBlock)progressBlock successBlock:(JRHTTPClientSuccessBlock)successBlock failBlock:(JRHTTPClientFailureBlock)failBlock{
    
    // 请求前先判断是否有网络
    if (_networkStatus == JRNetworkStatusUnknown ||  _networkStatus == JRNetworkStatusNotReachable) {
        failBlock ? failBlock(JR_ERROR) : nil;
        return nil;
    }
    
    return [[self manager] uploadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] fromFile:[NSURL URLWithString:uploadingFile] progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {
            progressBlock(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
        if (showHUD) {
            [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"上传中"];
        }
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
         successBlock ? successBlock(responseObject) : nil;
         failBlock && error ? failBlock(error) : nil;
        
    }];
    
}


@end
