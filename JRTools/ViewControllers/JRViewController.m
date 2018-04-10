//
//  JRViewController.m
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRViewController.h"
#import "UIViewController+JRAddition.h"
#import "UIView+Category.h"


@interface JRViewController ()

@end

@implementation JRViewController


#pragma mark - lifeCycle

- (void)loadView
{
    [super loadView];
    _screenScale = self.view.width / 320;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tx_commonSetup];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadGuideViewIfNeed];
}

- (void)loadGuideViewIfNeed
{
    //子类实现
}

-(void)guideViewDismiss
{
    //子类实现
}


@end
