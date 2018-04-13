//
//  JRMessageViewController.m
//  JRKits
//
//  Created by jackfrow on 2018/4/10.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRMessageViewController.h"
#import <MJRefresh.h>
#import "HLAPIClient.h"
#import "JRPersonalTableViewCell.h"
#import "JRPersonalModel.h"
#import <CocoaLumberjack.h>
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;

@interface JRMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView;

@property (nonatomic,strong) NSMutableArray* dataSource;

@end

@implementation JRMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.navigationItem.title = @"消息";
    [self.view addSubview:self.tableView];
    [self addRefresh];
    [self registerCell];
    [self addData];
    // Do any additional setup after loading the view.
}

-(void)addData{
    
    NSArray* models = @[@{@"name":@"james"},@{@"name":@"jack"},@{@"name":@"lee"}];
    
    NSArray* temp =  [NSArray yy_modelArrayWithClass:[JRPersonalModel class] json:models];
    
    [self.dataSource addObjectsFromArray:temp];
    
    [self.tableView reloadData];
    
}

-(void)registerCell{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"JRPersonalTableViewCell" bundle:nil] forCellReuseIdentifier:@"JRPersonalTableViewCell"];
    
}

-(void)addRefresh{
    
    __weak typeof(self) weakSelf = self;

        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
      
            [weakSelf _fetchDataWithOffset:@"0"];
            
        }];

    
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
         
            [weakSelf _fetchDataWithOffset:@"1"];
            
        }];

    
}

- (void)_fetchDataWithOffset:(NSString *)offset
{
     [[HLAPIClient sharedClient] BaiduSuccess:^(id responseObject) {
        
         [self.tableView.mj_header endRefreshing];
         [self.tableView.mj_footer endRefreshing];
         
        NSLog(@"responseObject = %@",responseObject);
        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        NSLog(@"error = %@",error.localizedDescription);
    }];
}

#pragma mark - lazy

-(UITableView *)tableView{
    
    if (_tableView == nil) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
    }
    
    return _tableView;
}

-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JRPersonalTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"JRPersonalTableViewCell"];
    
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 200;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //在这里进行log
    //产生Log
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
    
}

@end
