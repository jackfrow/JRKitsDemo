//
//  AppDelegate+SDK.h
//  JRKits
//
//  Created by 徐方豪 on 2018/4/3.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (SDK)


/**
 启动sdk
 */
-(void)sdkRun;


- (void)detectNetworkStaus;

/**
 *  启动ip管理器管理器
 */
- (void)setupLocalIPManager;

@end
