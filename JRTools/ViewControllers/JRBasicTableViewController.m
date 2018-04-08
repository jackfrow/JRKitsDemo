//
//  JRBasicTableViewController.m
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRBasicTableViewController.h"
#import "JRModelAttach.h"



@interface JRBasicTableViewController ()


/**
 The map to store the relationship With Models and Cells.
 */
@property (nonatomic,strong) NSMutableDictionary * modelCellBlockMap ;

@end

@implementation JRBasicTableViewController
@synthesize models = _models;

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
    
}

-(void)dealloc{
    
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;

    
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

    if (![modelClass isSubclassOfClass:JRBasicModel.class] && modelClass != JRBasicModel.class) {
        
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


@end
