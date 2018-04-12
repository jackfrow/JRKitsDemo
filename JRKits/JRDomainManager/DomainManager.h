//
//  DomainManager.h
//  JRKits
//
//  Created by jackfrow on 2018/4/11.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DomainModel.h"
#import <UIKit/UIKit.h>


@interface DomainManager : NSObject

/**
 单例初始化域名控制器
 */
+ (instancetype)sharedManager;

/**
 设置管理器的第一响应者
 */
- (void) managerRegisterFirstResponder:(id) responder;

/**
 跳转并回调选择后的地址
 */
+ (void) actionManagerPresentVC:(UIViewController *) viewController
                completionBlock:(void (^)(DomainModel *model))successBlock;

@end
