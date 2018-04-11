//
//  UIViewController+JRAddition.m
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "UIViewController+JRAddition.h"
#import "UIImage+JRAddition.h"
#import "UIColor+JRAddition.h"
#import "UIBarButtonItem+JRAddtion.h"
#import <AFNetworkReachabilityManager.h>

#define kTXBackgroundTag 69669

@implementation UIViewController (JRAddition)

-(void)tx_commonSetup{
       //是否可以push
       BOOL couldPop = (self.navigationController && self.navigationController.viewControllers.firstObject != self);
    if (couldPop) {
        self.navigationItem.hidesBackButton = NO;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self selector:@selector(tx_popViewController) image:[UIImage imageNamed:@"top_backicon"] title:nil];
    }
    //设置默认背景色
    UIImage *image = [self tx_edgesToEdgesBackgroundImage];
    if (image) {
        UIView *firstSubview = self.view.subviews.firstObject;
        if (([firstSubview isKindOfClass:[UITableView class]] &&
             ((UITableView *)firstSubview).backgroundView == nil) ||
            ([firstSubview isKindOfClass:[UICollectionView class]] &&
             ((UITableView *)firstSubview).backgroundView == nil)) {
                if ([firstSubview isKindOfClass:[UITableView class]])
                    ((UITableView *)firstSubview).backgroundView = [[UIImageView alloc] initWithImage:image];
                else
                    ((UICollectionView *)firstSubview).backgroundView = [[UIImageView alloc] initWithImage:image];
            }
        else if ([self.view viewWithTag:kTXBackgroundTag] == nil) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
            imageView.frame = self.view.bounds;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            imageView.tag = kTXBackgroundTag;
            [self.view insertSubview:imageView atIndex:0];
        }
    }

    
}

-(void)tx_popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIImage *)tx_edgesToEdgesBackgroundImage{
    
    //    return [UIImage imageNamed:@"bg"];
    return [UIImage imageFromColor:[UIColor viewControllerBackgroundColor]];
}

-(BOOL)showFailureError:(NSError *)error{
    
  return   [self showFailureError:error withAlert:YES];
}

-(BOOL)showFailureError:(NSError *)error withAlert:(BOOL)withAlert{
    
    if (![AFNetworkReachabilityManager sharedManager].reachable ||
        error.code == NSURLErrorNotConnectedToInternet) {
       //无网络连接
        return YES;
    }
    else if (error.code == NSURLErrorUnsupportedURL) {
        // Illegal URL, proving that getServerAddress API isn't called successfully.
        return YES;
    }
    else if (error.code == NSURLErrorTimedOut) {
        // Time out
        return YES;
    }
    else if (error.code == NSURLErrorCannotDecodeContentData ||
             [error.domain isEqualToString:NSCocoaErrorDomain]) {
        // Possibly PHP internal error html fetched.
    }
//    else if ([error.domain isEqualToString:XIMHTTPClientErrorDomain]) {
//        NSString *description = error.userInfo[@"description"];
//        if (description.length) {
//            if (!withAlert) {
//                [self dismissLoadingHUDWithFailureText:description];
//            }
//            else {
//                [self dismissLoadingHUD];
//                RIButtonItem *cancel = [RIButtonItem itemWithLabel:@"确定"];
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:description message:nil cancelButtonItem:cancel otherButtonItems:nil, nil];
//                [alertView show];
//            }
//            return YES;
//        }
//    }
    else {
        return NO;
    }
    return NO;
    
}

@end
