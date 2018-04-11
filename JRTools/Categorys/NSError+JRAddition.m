//
//  NSError+JRAddition.m
//  JRKits
//
//  Created by jackfrow on 2018/4/10.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "NSError+JRAddition.h"

@implementation NSError (JRAddition)

- (BOOL)isCanceledRequestError
{
    return [self.domain isEqualToString:NSURLErrorDomain] && self.code == NSURLErrorCancelled;
}

@end
