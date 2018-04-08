//
//  JRTabberConfig.h
//  JRTabbarViewController
//
//  Created by 徐方豪 on 2018/4/4.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CYLTabBarController.h>

@interface JRTabberConfig : NSObject

/**
 根tabbar
 */
@property (nonatomic,readonly,strong) CYLTabBarController* tabBarController;

@end
