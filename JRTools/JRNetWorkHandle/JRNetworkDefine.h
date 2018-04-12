//
//  JRNetworkDefine.h
//  JRKits
//
//  Created by jackfrow on 2018/4/11.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#ifndef JRNetworkDefine_h
#define JRNetworkDefine_h

typedef void (^JRHTTPClientSuccessBlock)(id responseObject);
typedef void (^JRHTTPClientFailureBlock)(NSError *error);
typedef void (^JRHTTPClientProgressBlock)(unsigned long long loadedSize, unsigned long long totalSize);


#define JRHTTPErrorDomain @"JRHTTPErrorDomain"
#define JRHTTPErroCodeParameterInvalid 80000

#define JR_API_PARAMETERS_CHECK(condition) \
if (!(condition)) { \
if (failure) failure([NSError errorWithDomain:JRHTTPErrorDomain code:JRHTTPErroCodeParameterInvalid userInfo:nil]); \
return nil; \
}
#define JR_HTTP_FAILURE ^(NSURLSessionDataTask *  task, NSError *error) { \
if (failure) { \
failure(error); \
}\
}

#define JR_DEFINE_API(METHOD) \
- (NSURLSessionTask*)METHOD ## Success:(JRHTTPClientSuccessBlock)success failure:(JRHTTPClientFailureBlock)failure

#define JR_DEFINE_PARAMS_API(METHOD) \
- (NSURLSessionTask*)METHOD success:(JRHTTPClientSuccessBlock)success failure:(JRHTTPClientFailureBlock)failure

/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, JRNetworkStatus) {
    /**
     *  未知网络
     */
    JRNetworkStatusUnknown             = 1 << 0,
    /**
     *  无法连接
     */
    JRNetworkStatusNotReachable        = 1 << 2,
    /**
     *  3G,4G
     */
    JRNetworkStatusWWAN              = 1 << 3,
    /**
     * WIFI
     */
    JRNetworkStatusWIFI              = 1 << 4,
    
};

#pragma mark -  Environment
//STAGING

//PRELIVE

//PREPRODUCT

//LIVE

#endif /* JRNetworkDefine_h */
