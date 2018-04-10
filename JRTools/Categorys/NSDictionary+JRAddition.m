//
//  NSDictionary+JRAddition.m
//  JRKits
//
//  Created by jackfrow on 2018/4/10.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "NSDictionary+JRAddition.h"

@implementation NSDictionary (JRAddition)

- (id)objectOrNilForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    else
    {
        return object;
    }
}

-(id)objectOrSpaceForKey:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNull class]] || object == nil)
    {
        return @"";
    }
    else
    {
        return object;
    }
}

@end
