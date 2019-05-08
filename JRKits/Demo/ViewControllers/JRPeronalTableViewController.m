//
//  JRPeronalTableViewController.m
//  JRKits
//
//  Created by jackfrow on 2018/4/8.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRPeronalTableViewController.h"
#import "JRPersonalTableViewCell.h"
#import "JRPersonalModel.h"
#import "TestViewController.h"
#import "HLAPIClient.h"

@interface JRPeronalTableViewController ()

@end

@implementation JRPeronalTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.JHeaderRefreshEnable = YES;
        self.JFooterRefreshEnable = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"首页";

   NSArray* models = @[@{@"name":@"james"},@{@"name":@"jack"},@{@"name":@"lee"}];

   NSArray* temp =  [NSArray yy_modelArrayWithClass:[JRPersonalModel class] json:models];

    [self.models addObjectsFromArray:temp];

    [self.tableView reloadData];
}


-(void)loadCellModelMapping{
    
    [self registerModelClass:[JRPersonalModel class ] mappedNibIndentifier:[UINib nibWithNibName:@"JRPersonalTableViewCell" bundle:nil] cellClass:[JRPersonalTableViewCell class]];
    
//    [self registerModelClass:[JRPersonalModel class]  mappedCellBlock:^Class(id model) {
//
//        return nil;
//    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    TestViewController* vc = [[TestViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- inheritMethod
-(NSURLSessionTask *)fetchDataWithOffset:(NSString *)offset{
    
    return [[HLAPIClient sharedClient] BaiduSuccess:^(id responseObject) {
        
        [self finishFetchWithModels:self.models offset:@"" hasMore:YES];
        
    } failure:^(NSError *error) {
        
        [self failedToFetchingDataWithError:error];
    }];
    
}

@end
