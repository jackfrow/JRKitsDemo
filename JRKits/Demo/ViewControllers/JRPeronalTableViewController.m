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
    
    self.navigationItem.title = @"个人信息";

   NSArray* models = @[@{@"name":@"james"},@{@"name":@"james"},@{@"name":@"james"}];

   NSArray* temp =  [NSArray yy_modelArrayWithClass:[JRPersonalModel class] json:models];

    [self.models addObjectsFromArray:temp];

    [self.tableView reloadData];
    
    // Do any additional setup after loading the view.
}

-(void)loadCellModelMapping{
    
//    [self registerModelClass:[JRPersonalModel class] mappedCellClass:[JRPersonalTableViewCell class]];
    
    [self registerModelClass:[JRPersonalModel class ] mappedNibIndentifier:[UINib nibWithNibName:@"JRPersonalTableViewCell" bundle:nil] cellClass:[JRPersonalTableViewCell class]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    TestViewController* vc = [[TestViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark -- inheritMethod
-(NSOperation *)fetchDataWithOffset:(NSString *)offset{
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self finishFetchWithModels:@[] offset:@"1" hasMore:YES];
        
    });
    
    return nil;
    
}

@end
