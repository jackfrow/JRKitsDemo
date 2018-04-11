//
//  DomainManager.m
//  JRKits
//
//  Created by jackfrow on 2018/4/11.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "DomainManager.h"

@implementation DomainManager

+(instancetype)sharedManager{
    
    static DomainManager *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tools = [[DomainManager alloc] init];
    });
    return tools;
    
}

@end
