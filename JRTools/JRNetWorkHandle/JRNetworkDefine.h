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
