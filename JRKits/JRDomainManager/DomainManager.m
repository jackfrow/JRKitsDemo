//
//  DomainManager.m
//  JRKits
//
//  Created by jackfrow on 2018/4/11.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "DomainManager.h"
#import <UIKit/UIKit.h>
#import "DomainManagerVc.h"

@implementation DomainManager

+(instancetype)sharedManager{
    
    static DomainManager *tools;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        tools = [[DomainManager alloc] init];
    });
    return tools;
    
}

- (void)managerRegisterFirstResponder:(id)responder
{
    // 设置允许摇一摇功能
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [responder becomeFirstResponder];
}

+(void)actionManagerPresentVC:(UIViewController *)viewController completionBlock:(void (^)(DomainModel *))successBlock{
    
    DomainManagerVc *domainVc = [[DomainManagerVc alloc] initWithNibName:@"DomainManagerVc" bundle:[NSBundle bundleForClass:[DomainManager class]]];
    
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:domainVc];
    
    domainVc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [viewController presentViewController:navigation animated:YES completion:nil];
    
    [domainVc setSelectedSuceesBlock:^(DomainModel *model) {
        if (successBlock) {
            successBlock(model);
        }
    }];
    
    
}

@end
