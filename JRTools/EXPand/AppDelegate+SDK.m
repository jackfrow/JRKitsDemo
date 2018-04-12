//
//  AppDelegate+SDK.m
//  JRKits
//
//  Created by 徐方豪 on 2018/4/3.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "AppDelegate+SDK.h"
#import <AFNetworkReachabilityManager.h>
#import "DSToast.h"
#import "JRHTTPClient.h"


@implementation AppDelegate (SDK)

/**
 检测网络状态
 */
- (void)detectNetworkStaus {
    AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [reachabilityManager startMonitoring];
    [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

          //在这里可以定义网络状态切换的提示
        if (status == AFNetworkReachabilityStatusNotReachable){//无网络连接
            [JRHTTPClient sharedClient].networkStatus = JRNetworkStatusNotReachable;
            [[DSToast toastWithText:@"无网络连接"] show];
        }else if (status == AFNetworkReachabilityStatusUnknown){//未知网络
             [JRHTTPClient sharedClient].networkStatus = JRNetworkStatusUnknown;
            [[DSToast toastWithText:@"未知网络"] show];
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){//流量
            [JRHTTPClient sharedClient].networkStatus = JRNetworkStatusWWAN;
            [[DSToast toastWithText:@"你已切换至流量"] show];
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){//WIFI
            [JRHTTPClient sharedClient].networkStatus = JRNetworkStatusWIFI;
            [[DSToast toastWithText:@"你已切换至WIFI"] show];        }
    }];
}

@end
