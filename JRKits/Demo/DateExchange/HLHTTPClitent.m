//
//  HLHTTPClitent.m
//  JRKits
//
//  Created by jackfrow on 2018/4/12.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "HLHTTPClitent.h"

@implementation HLHTTPClitent

+(instancetype)sharedClient{
    
    static dispatch_once_t once;
    static HLHTTPClitent *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[self alloc]init];
        __singleton__.requestTimeout = JR_REQUEST_TIMEOUT;
    });
    return __singleton__;
    
}

@end
