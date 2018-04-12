//
//  UIViewController+Shake.m
//  JRKits
//
//  Created by 徐方豪 on 2018/4/12.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "UIViewController+Shake.h"
#import <AudioToolbox/AudioToolbox.h>


@implementation UIViewController (Shake)

#pragma mark --- 摇一摇
// 结束摇动代理方法
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //振动效果
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //如果有摇动动作，就做相应操作
    if (event.subtype == UIEventSubtypeMotionShake) {
    
    }
}

@end
