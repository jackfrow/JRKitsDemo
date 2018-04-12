//
//  JRBasicTableViewController.h
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRModelCellMapping.h"
#import "JRViewController.h"
#import "JRListFetching.h"


/**
 JRBasicTableViewController实现了数据源和视图的绑定，只需要注册和传入正确的数据源，即可获得对应的视图，该类只支持单section 的tableview视图.所有的model都要继承自基类cell才可以
 */
@interface JRBasicTableViewController : JRViewController<JRModelCellMapping,UITableViewDelegate,UITableViewDataSource,JRListFetching>

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic,strong) UITableView * tableView ;


/**
 configure cell with detail situation here.
 */
-(void)configureCell:(UITableViewCell<JRModelAttach> *)cell forIndexPath:(NSIndexPath*)indexPath;


@end
