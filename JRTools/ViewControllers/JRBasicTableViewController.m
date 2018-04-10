//
//  JRBasicTableViewController.m
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRBasicTableViewController.h"
#import "JRModelAttach.h"
#import <MJRefresh.h>


@interface JRBasicTableViewController ()


/**
 The map to store the relationship With Models and Cells.
 */
@property (nonatomic,strong) NSMutableDictionary * modelCellBlockMap ;

/**
 请求的Operation.
 */
@property (nonatomic, weak) NSOperation *fetchingOperation;


/**
 请求位置
 */
@property (nonatomic, copy) NSString *offset;

/**
 是否已经刷新
 */
@property (nonatomic,assign) BOOL hasRereshed;



@end

@implementation JRBasicTableViewController
@synthesize models = _models;
@synthesize JFooterRefreshEnable = _JFooterRefreshEnable;
@synthesize AutomaticRefreshWhenPresented = _AutomaticRefreshWhenPresented;
@synthesize JHeaderRefreshEnable = _JHeaderRefreshEnable;

#pragma mark - lazy

-(NSMutableArray *)models{
    
    if (_models == nil) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
    
}

-(NSMutableDictionary *)modelCellBlockMap{
    
    if (_modelCellBlockMap == nil) {
        _modelCellBlockMap = [[NSMutableDictionary alloc] init];
    }
    return _modelCellBlockMap;
    
}

-(UITableView *)tableView{
    
    if (_tableView == nil) {
    
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
    }
    
    return _tableView;
}

#pragma mark - UIViewController Methods

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.JHeaderRefreshEnable = YES;
        self.JFooterRefreshEnable = YES;
        self.AutomaticRefreshWhenPresented = YES;
        self.offset = @"0";
    }
    return self;
    
}

-(void)loadView{
    [super loadView];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self loadCellModelMapping];
    [self _addRefreshViewIfNeeded];
    
}

-(void)viewDidLayoutSubviews{
    
    [self _addRefreshViewIfNeeded];
    
    if (!_hasRereshed && _AutomaticRefreshWhenPresented) {
        self.hasRereshed = YES;
        [self beginRefresh];
    }
}



-(void)dealloc{
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    [self.fetchingOperation cancel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - APIs

- (NSArray *)registeredModelClasses
{
    return self.modelCellBlockMap.allKeys;
}

-(void)loadCellModelMapping{
    
     // should be implemented by subclass
    
}

-(void)unregisterMappingWithModelClass:(Class)modelClass{
    
    if (modelClass) {
        NSString* modelClassString = NSStringFromClass(modelClass);
        [self.modelCellBlockMap removeObjectForKey:modelClassString];
    }
    
}

-(void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass{
    
    if (![cellClass conformsToProtocol:@protocol(JRModelAttach)]) {
        
         NSLog(@"Failed to register model and cell classes. %@ doesn't conform to JRModelAttach protocol.", cellClass);
        return;
    }
    
    [self registerModelClass:modelClass mappedCellBlock:^Class(id model) {
        return cellClass;
    }];
    
}

-(void)registerModelClass:(Class)modelClass mappedCellBlock:(Class (^)(id))cellBlock{
    
    if (![modelClass isSubclassOfClass:JRBasicModel.class] && modelClass != JRBasicModel.class) {
        
           NSLog(@"Failed to register model and cell classes to JRBasicTableViewController. %@ is not the subclass of JRBasicModel.", modelClass);
        return;
    }
    
    NSString* classString = NSStringFromClass(modelClass);
    
    self.modelCellBlockMap[classString] = cellBlock;
    
}

-(void)registerModelClass:(Class)modelClass mappedNibIndentifier:(UINib *)nibIndentifier cellClass:(__unsafe_unretained Class)cellClass{

    if (![cellClass conformsToProtocol:@protocol(JRModelAttach)]) {
        
        NSLog(@"Failed to register model and cell classes. %@ doesn't conform to JRModelAttach protocol.", nibIndentifier);
        return;
    }

    if (![modelClass isSubclassOfClass:JRBasicModel.class] &&  [modelClass isSubclassOfClass:JRBasicModel.class] && modelClass != JRBasicModel.class) {
        
        NSLog(@"Failed to register model and cell classes to JRBasicTableViewController. %@ is not the subclass of JRBasicModel.", modelClass);
        return;
    }

    
    [self.tableView registerNib:nibIndentifier forCellReuseIdentifier:NSStringFromClass(cellClass)];

    
    [self registerModelClass:modelClass mappedCellBlock:^Class(id model) {
        return cellClass;
    }];
    
    
}

-(JRBasicModel *)modelAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.row < self.models.count ? self.models[indexPath.row] : nil;
}

-(Class)mappedCellClassForModel:(JRBasicModel *)model{
    
    Class(^block)(JRBasicModel* model) = self.modelCellBlockMap[NSStringFromClass(model.class)];
 
    return block ? block(model) : nil;
    
}

-(NSString *)reuseIdentifierWithCellClass:(Class)cellClass{
    
    return  cellClass ? NSStringFromClass(cellClass) : nil;
    
}

-(void)configureCell:(UITableViewCell<JRModelAttach> *)cell forIndexPath:(NSIndexPath *)indexPath{
    
        // should be implemented by subclass
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // We only support one section tableview currently.
    return self.models.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JRBasicModel* model = [self modelAtIndexPath:indexPath];
    
    Class cellClass = [self mappedCellClassForModel:model];
    
    NSString* reuseIndentifier = [self reuseIdentifierWithCellClass:cellClass];
    
    UITableViewCell<JRModelAttach> * cell = [tableView dequeueReusableCellWithIdentifier: reuseIndentifier];
    
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
    }
    
    cell.model = model;
    
    [self configureCell:cell forIndexPath:indexPath];
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // should be implemented by subclass
}


#pragma mark - Private Methods

- (void)_addRefreshViewIfNeeded
{
     __weak typeof(self) weakSelf = self;
    if (self.JHeaderRefreshEnable && !self.tableView.mj_header) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.offset = @"0";
            [weakSelf _fetchDataWithOffset:self.offset];
        }];
    }
    
    if (self.JFooterRefreshEnable && !self.tableView.mj_footer) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf _fetchDataWithOffset:self.offset];
        }];
    }
   
}

#pragma mark - JRListFetching

-(void)beginRefresh{
    
    // 在加载更多的过程中刷新，取消原有请求
    if (self.fetchingOperation) [self.fetchingOperation cancel];
      [self _fetchDataWithOffset:self.offset];
    
}

- (void)_fetchDataWithOffset:(NSString *)offset
{
    self.fetchingOperation = [self fetchDataWithOffset:offset];
}

-(void)finishFetchWithModels:(NSArray *)models offset:(NSString *)offset hasMore:(BOOL)hasMore{

    
    [self.tableView.mj_header endRefreshing];//结束下拉刷新
    [self.tableView.mj_footer endRefreshing];//结束加载更多
    
}

-(void)failedToFetchingDataWithError:(NSError *)error{
    //暂未实现
}


@end
