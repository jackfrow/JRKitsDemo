//
//  JRHTTPClient.h
//  JRKits
//
//  Created by jackfrow on 2018/4/11.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRNetworkDefine.h"


FOUNDATION_EXPORT NSString *const JRHTTPClientErrorDomain;

@interface JRHTTPClient : NSObject

/**
 当前网络状态
 */
@property (nonatomic,assign) JRNetworkStatus networkStatus;

+ (instancetype)sharedClient;

/**
 默认baseUrl
 */
@property (nonatomic,copy) NSString *normalUrl;

/**
 设置token
 */
@property (nonatomic,copy) NSString *baseToken;

/**
 接口请求超时时间
 */
@property (nonatomic,assign) NSTimeInterval requestTimeout;


/**
 验证结果的有效性
 */
- (BOOL)isAvaiableWithResponse:(NSDictionary *)responseObject;

#pragma mark --- 请求参数接口
//POST
- (NSURLSessionTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *  responseObject, NSError * error))failure;

//GET
- (NSURLSessionTask *)GET:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask * _Nonnull task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *  responseObject, NSError * error))failure;


/**
 多图片上传

 @param imageArray       图片对象集合
 @param url              请求路径
 @param params           拼接参数
 @param showHUD          是否显示上传进度
 @param progressBlock    上传进度
 @param successBlock     成功回调
 @param failBlock        失败回调
 */
- (NSURLSessionTask *)uploadWithImageArray:(NSMutableArray *)imageArray
                                       url:(NSString *)url
                                    params:(NSDictionary *)params
                                   showHUD:(BOOL)showHUD
                             progressBlock:(JRHTTPClientProgressBlock)progressBlock
                              successBlock:(JRHTTPClientSuccessBlock)successBlock
                                 failBlock:(JRHTTPClientFailureBlock)failBlock;




/**
 *  文件上传接口
 *
 *  @param url              上传文件接口地址
 *  @param uploadingFile    上传文件路径
 *  @param progressBlock    上传进度
 *  @param successBlock     成功回调
 *  @param failBlock        失败回调
 *
 *  @return 返回的对象中可取消请求
 */
- (NSURLSessionTask *)uploadFileWithUrl:(NSString *)url
                          uploadingFile:(NSString *)uploadingFile
                                showHUD:(BOOL)showHUD
                          progressBlock:(JRHTTPClientProgressBlock)progressBlock
                           successBlock:(JRHTTPClientSuccessBlock)successBlock
                              failBlock:(JRHTTPClientFailureBlock)failBlock;


@end
