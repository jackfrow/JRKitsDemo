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

@interface JRPeronalTableViewController ()

@end

@implementation JRPeronalTableViewController

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

@end
