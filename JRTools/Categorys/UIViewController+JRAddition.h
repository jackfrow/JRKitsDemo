//
//  UIViewController+JRAddition.h
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (JRAddition)


/**
 公共初始化
 */
-(void)tx_commonSetup;


/**
 推出控制器
 */
-(void)tx_popViewController;



/**
 设置控制器背景色
 */
- (UIImage *)tx_edgesToEdgesBackgroundImage;

@end
