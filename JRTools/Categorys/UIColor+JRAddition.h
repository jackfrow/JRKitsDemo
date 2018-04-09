//
//  UIColor+JRAddition.h
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JRAddition)

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)PinkColor;
+ (UIColor *)hightLightPinkColor;
+ (UIColor *)viewControllerBackgroundColor;

@end
