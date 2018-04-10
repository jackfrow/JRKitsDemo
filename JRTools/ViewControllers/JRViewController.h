//
//  JRViewController.h
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Masonry.h>

@interface JRViewController : UIViewController

{
    UIImageView *_guideView;
}

@property(nonatomic, assign, readonly) CGFloat screenScale;//尺寸等比放缩参数

- (void)loadGuideViewIfNeed;//新手引导重写此组方法
- (void)guideViewDismiss;

@end
