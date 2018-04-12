//
//  HLAPIClient.m
//  JRKits
//
//  Created by jackfrow on 2018/4/12.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "HLAPIClient.h"

@implementation HLAPIClient

-(NSURLSessionTask *)BaiduSuccess:(JRHTTPClientSuccessBlock)success failure:(JRHTTPClientFailureBlock)failure{

//    http://staging.admin.hilife.sg/service/api_user/svcAboutYou
return  [self POST:@"https://www.baidu.com" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id responseObject) {
    
    if (success) success(responseObject);
    
    } failure:JR_HTTP_FAILURE];
    
    
}

@end
