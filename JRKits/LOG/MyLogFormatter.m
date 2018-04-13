//
//  MyLogFormatter.m
//  testLog
//
//  Created by 徐方豪 on 2018/2/5.
//  Copyright © 2018年 徐方豪. All rights reserved.
//

#import "MyLogFormatter.h"

@implementation MyLogFormatter

-(NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    
    NSMutableDictionary *logDict = [NSMutableDictionary dictionary];
    //取得文件名
    NSString *locationString;
    NSArray *parts = [logMessage->_file componentsSeparatedByString:@"/"];
    if ([parts count] > 0)
        locationString = [parts lastObject];
    if ([locationString length] == 0)
        locationString = @"No file";
    //这里的格式: {"location":"myfile.m:120(void a::sub(int)"}， 文件名，行数和函数名是用的编译器宏 __FILE__, __LINE__, __PRETTY_FUNCTION__
//    logDict[@"location"] = [NSString stringWithFormat:@"%@:%lu(%@)", locationString, (unsigned long)logMessage->_line, logMessage->_function];
    
    logDict[@"message"] = [NSString stringWithFormat:@"%@",logMessage->_message];
    
    logDict[@"fileName"] = [NSString stringWithFormat:@"%@",logMessage->_fileName];
    
    logDict[@"function"] = [NSString stringWithFormat:@"%@",logMessage->_function];
    
    //尝试将logDict内容转为字符串，其实这里可以直接构造字符串，但真实项目中，肯定需要很多其他的信息，不可能仅仅文件名、行数和函数名就够了的。
    
    NSError *error;
    
    NSData *outputJson = [NSJSONSerialization dataWithJSONObject:logDict options:0 error:&error];
    
    if (error) {
        return @"{\"location\":\"error\"}";
    }

    NSString *jsonString = [[NSString alloc] initWithData:outputJson encoding:NSUTF8StringEncoding];

    if (jsonString)
        return jsonString;

    return @"{\"location\":\"error\"}";
    
}

@end
