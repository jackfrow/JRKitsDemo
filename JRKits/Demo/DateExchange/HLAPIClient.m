//
//  HLAPIClient.m
//  JRKits
//
//  Created by jackfrow on 2018/4/12.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "HLAPIClient.h"



@implementation HLAPIClient

+(instancetype)sharedClient{
    
    static dispatch_once_t once;
    static HLAPIClient *__singleton__;
    dispatch_once(&once, ^ {
        __singleton__ = [[self alloc]init];
        __singleton__.requestTimeout = JR_REQUEST_TIMEOUT;
    });
    return __singleton__;
    
}

-(NSURLSessionTask *)BaiduSuccess:(JRHTTPClientSuccessBlock)success failure:(JRHTTPClientFailureBlock)failure{

//    http://staging.admin.hilife.sg/service/api_user/scvGetMyPayMents
//https://www.baidu.com
return  [self POST:@"http://staging.admin.hilife.sg/service/api_user/scvGetMyPayMents" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
    
    if (success) success(responseObject);
    
    } failure:JR_HTTP_FAILURE];
    
}

-(NSURLSessionTask *)uploadHeader:(NSMutableArray *)images success:(JRHTTPClientSuccessBlock)success failure:(JRHTTPClientFailureBlock)failure{
    
    return [self uploadWithImageArray:images url:@"http://staging.admin.hilife.sg/service/api_user/svcUploadHeadPortrait" params:nil showHUD:YES progressBlock:nil successBlock:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failBlock:JR_HTTP_ERROR];
    
}


@end
