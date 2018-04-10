//
//  NSDictionary+JRAddition.h
//  JRKits
//
//  Created by jackfrow on 2018/4/10.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JRAddition)

/**
 * 取值的保护方法
 *
 *
 *
 **/
- (id)objectOrNilForKey:(NSString *)key;
-(id)objectOrSpaceForKey:(NSString *)key;

@end
