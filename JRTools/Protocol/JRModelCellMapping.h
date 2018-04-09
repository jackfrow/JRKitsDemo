//
//  JRModelBinding.h
//  JRKits
//
//  Created by jackfrow on 2018/4/8.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRModelAttach.h"

@protocol JRModelCellMapping <NSObject>

/**
 All the models should be put in this array.
 */
@property (nonatomic,strong)  NSMutableArray* models; ;


/**
 The Defualt implementation returns the self.models[indexPath.row]
 */
-(JRBasicModel*)modelAtIndexPath:(NSIndexPath*)indexPath;


/** Use this method to inheritedly confgure cells.*/
-(void)loadCellModelMapping;


/**
 Establish Model <-> Cell mapping
 */
-(void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass;



/**
 Establish Model <-> Cell mapping using Block returned Value.
 Remeber to weakify self if it presented in the CellBlock.
 */
-(void)registerModelClass:(Class)modelClass mappedCellBlock:(Class (^) (id model)) cellBlock;


/**
 Establish Model <-> Cell mapping using NibClass,cellClass.
 */
-(void)registerModelClass:(Class)modelClass  mappedNibIndentifier:(UINib*)nibIndentifier cellClass:(Class)cellClass;

/**
 Destruct Model <-> Cell mapping relationship.
 */
-(void)unregisterMappingWithModelClass:(Class)modelClass;


/**
 All registered model class in a NSArray.
 */
-(NSArray*)registeredModelClasses;


/**
 Return the class for model in relationship in mapping.
 */
-(Class)mappedCellClassForModel:(JRBasicModel*)model;


/**
 Convert class to nsstring.
 */
-(NSString*)reuseIdentifierWithCellClass:(Class)cellClass;

@end
