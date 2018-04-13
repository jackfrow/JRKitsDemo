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
#import "DomainManager.h"
#import "MyLogger.h"
#import "MyLogFormatter.h"


@implementation AppDelegate (SDK)

-(void)sdkRun{
    [self detectNetworkStaus];
    
    [self setupLocalIPManager];
    
    [self addLog];
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

/**
 *  启动ip管理器管理器
 */
- (void)setupLocalIPManager
{
    [[DomainManager sharedManager] managerRegisterFirstResponder:self];
    // IP地址管理
    DomainModel* model = [NSKeyedUnarchiver  unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@""]];
    if (model.mainDomain) {
        [[JRHTTPClient sharedClient] setNormalUrl:model.mainDomain];
    }else{
        [[JRHTTPClient sharedClient] setNormalUrl:@"http://staging.admin.hilife.sg/service"];
    }
    
}


/**
 log 日志
 */
-(void)addLog{
    
    //custom log message
    MyLogger *logger = [[MyLogger alloc] init];
    [logger setLogFormatter:[[MyLogFormatter alloc]init]];
    [DDLog addLogger:logger];
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    
}

@end
