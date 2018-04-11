//
//  JRListFetching.h
//  JRKits
//
//  Created by jackfrow on 2018/4/9.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JRListFetching <NSObject>

@optional
/**
 是否启用下拉刷新，不启用的时候会隐藏掉下拉刷新.Default to YES.
 */
@property (nonatomic,assign) BOOL JHeaderRefreshEnable;


/**
 是否启用上拉加载更多，不启用的时候会隐藏掉上拉加载.Default to YES.
 */
@property (nonatomic,assign) BOOL JFooterRefreshEnable;


/**
 是否展示vc后自动刷新.Default to YES.
 */
@property (nonatomic,assign) BOOL AutomaticRefreshWhenPresented;


/**
 调用这个方法开始刷新
 */
-(void)beginRefresh;


/**
 子类重写这个方法来完成获取数据的请求发起。父类会在需要刷新的时候调用此方法。
 PS:子类不要调用这个方法，等着被掉就行
 */
-(NSURLSessionTask*)fetchDataWithOffset:(NSString*)offset;


/**
 子类完成数据获取的时候调用这个方法。子类的实现中应该先调用 super.
 @param models 转换好的 JRBasicModel 数组
 @param offset 下一页 offset 值，传 nil 或 @"0" 会重置已有数据
 @param hasMore 是否还有更多
 */
-(void)finishFetchWithModels:(NSArray*)models offset:(NSString*)offset hasMore:(BOOL)hasMore;


/**
 子类请求发生错误的时候调用这个方法，子类根据 error.userInfo[@"description"] 显示错误原因。子类的实现中应该先调用 super.
 */
-(void)failedToFetchingDataWithError:(NSError*)error;

@end
