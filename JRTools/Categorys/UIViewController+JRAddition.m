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

@end
