//
//  JRViewController.m
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRViewController.h"
#import "UIViewController+JRAddition.h"


@interface JRViewController ()


/**
 是否已经刷新
 */
@property (nonatomic,assign) BOOL hasRereshed;

@end

@implementation JRViewController
@synthesize JFooterRefreshEnable = _JFooterRefreshEnable;
@synthesize JHeaderRefreshEnable = _JHeaderRefreshEnable;
@synthesize AutomaticRefreshWhenPresented = _AutomaticRefreshWhenPresented;

#pragma mark - lifeCycle


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.JHeaderRefreshEnable = YES;
        self.JFooterRefreshEnable = YES;
        self.AutomaticRefreshWhenPresented = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self tx_commonSetup];
}

-(void)viewDidLayoutSubviews{
    
    if (!_hasRereshed && _AutomaticRefreshWhenPresented) {
        self.hasRereshed = YES;
        [self beginRefresh];
    }
}

#pragma mark - JRListFetching
-(void)beginRefresh{
   
    [self fetchDataWithOffset:nil];
    
}


-(NSOperation *)fetchDataWithOffset:(NSString *)offset{
    //子类实现
    return nil;
}

-(void)finishFetchWithModels:(NSArray *)models offset:(NSString *)offset hasMore:(BOOL)hasMore{
    //子类实现
    
}

-(void)failedToFetchingDataWithError:(NSError *)error{
    //子类实现
}

@end
