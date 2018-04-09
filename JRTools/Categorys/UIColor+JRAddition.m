//
//  UIColor+JRAddition.m
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "UIColor+JRAddition.h"

@implementation UIColor (JRAddition)

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    
    return [UIColor colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    if ([hexString length] <= 0)
        return nil;
    
    // Remove '#'
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    // Invalid if not 3, or 6 characters
    NSUInteger length = [hexString length];
    if (length != 3 && length != 6) {
        return nil;
    }
    
    NSUInteger digits = length / 3;
    CGFloat maxValue = ((digits == 1) ? 15.0 : 255.0);
    
    NSString *redString = [hexString substringWithRange:NSMakeRange(0, digits)];
    NSString *greenString = [hexString substringWithRange:NSMakeRange(digits, digits)];
    NSString *blueString = [hexString substringWithRange:NSMakeRange(2 * digits, digits)];
    
    NSUInteger red = 0;
    NSUInteger green = 0;
    NSUInteger blue = 0;
    
    sscanf([redString UTF8String], "%lx", (unsigned long *)&red);
    sscanf([greenString UTF8String], "%lx", (unsigned long *)&green);
    sscanf([blueString UTF8String], "%lx", (unsigned long *)&blue);
    
    return [UIColor colorWithRed:red/maxValue green:green/maxValue blue:blue/maxValue alpha:alpha];
}



+(UIColor *)PinkColor{
    
     return [UIColor colorWithRed:250/256.0 green:90/256.0 blue:122/256.0 alpha:1];
}

+(UIColor *)hightLightPinkColor{
     return [UIColor colorWithRed:250/256.0 green:90/256.0 blue:122/256.0 alpha:0.5];
}

+ (UIColor *)commonBackGray
{
    return [UIColor colorWithHexString:@"#f1f1f1"];
}

+ (UIColor *)viewControllerBackgroundColor
{
    return [UIColor commonBackGray];
}

@end
