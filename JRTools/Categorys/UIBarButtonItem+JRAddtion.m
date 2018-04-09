//
//  UIBarButtonItem+JRAddtion.m
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "UIBarButtonItem+JRAddtion.h"
#import "UIColor+JRAddition.h"

@implementation UIBarButtonItem (JRAddition)

+ (instancetype)itemWithTarget:(id)target selector:(SEL)selector image:(UIImage *)image title:(NSString *)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [button setTitleColor:[UIColor PinkColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor hightLightPinkColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor hightLightPinkColor] forState:UIControlStateDisabled];
    }
    [button sizeToFit];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.exclusiveTouch = YES;
    button.clipsToBounds = NO;
    button.bounds = CGRectMake(0.0, 0.0, CGRectGetWidth(button.bounds), CGRectGetHeight(button.bounds));
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
