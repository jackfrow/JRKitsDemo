//
//  JRinitKit.m
//  JRTabbarViewController
//
//  Created by 徐方豪 on 2018/4/4.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRinitKit.h"
#import <UIKit/UIKit.h>
#import "JRTabberConfig.h"
#import "UINavigationBar+JRAddtion.h"

@implementation JRinitKit

+(void)run{
    
    [self setApplicationRoot];
    [UINavigationBar customUI];//set style for UINavigationBar
}

+(void)setApplicationRoot{
    
    id<UIApplicationDelegate> appDelegate  =  [UIApplication sharedApplication].delegate ;
    
    appDelegate.window  = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    appDelegate.window.backgroundColor = [UIColor whiteColor];
    JRTabberConfig *tabBarControllerConfig = [[JRTabberConfig alloc] init];
    appDelegate.window.rootViewController = tabBarControllerConfig.tabBarController;
    [appDelegate.window makeKeyAndVisible];
    
}



@end
