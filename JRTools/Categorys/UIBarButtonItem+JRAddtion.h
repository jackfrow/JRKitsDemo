//
//  UIBarButtonItem+JRAddtion.h
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (JRAddtion)


/**
 快捷创建UIBarButtonItem
 */
+ (instancetype)itemWithTarget:(id)target selector:(SEL)selector image:(UIImage *)image title:(NSString *)title;

@end
