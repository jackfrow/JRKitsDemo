//
//  JRBasicNavigationController.m
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRBasicNavigationController.h"

@interface JRBasicNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation JRBasicNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])  {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
        self.delegate = weakSelf;
    }
    
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if ([self.topViewController isMemberOfClass:[viewController class]]) {
        return;
    }
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:animated];
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return self.childViewControllers.count > 1;
    
}



@end
