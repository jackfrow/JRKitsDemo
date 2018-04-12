//
//  HLAPIClient.h
//  JRKits
//
//  Created by jackfrow on 2018/4/12.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "HLHTTPClitent.h"

@interface HLAPIClient : HLHTTPClitent

//请求百度数据
JR_DEFINE_API(Baidu);

//更新头像
JR_DEFINE_PARAMS_API(uploadHeader:(NSMutableArray *)images);

@end
