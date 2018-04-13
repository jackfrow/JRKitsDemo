//
//  MyLogger.m
//  testLog
//
//  Created by 徐方豪 on 2018/2/5.
//  Copyright © 2018年 徐方豪. All rights reserved.
//

#import "MyLogger.h"

@interface MyLogger()

/**
 存储log信息的数组
 */
@property (nonatomic,strong) NSMutableArray* logMessagesArray;

@end

@implementation MyLogger

- (instancetype)init {
    self = [super init];
    if (self) {
        self.deleteInterval = 0;
        self.maxAge = 0;
        self.deleteOnEverySave = NO;
        self.saveInterval = 60;//秒数限制
        self.saveThreshold = 500;//消息数量限制
        //别忘了在 dealloc 里 removeObserver
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveOnSuspend)
                                                     name:@"UIApplicationWillResignActiveNotification"
                                                   object:nil];
    }
    return self;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)saveOnSuspend {
    dispatch_async(_loggerQueue, ^{
        [self db_save];
    });
}

- (BOOL)db_log:(DDLogMessage *)logMessage
{
    if (!_logFormatter) {
        //没有指定 formatter
        return NO;
    }
    if (!_logMessagesArray)
        _logMessagesArray = [NSMutableArray arrayWithCapacity:500]; // 我们的saveThreshold只有500，所以一般情况下够了
    if ([_logMessagesArray count] > 2000) {
        // 如果段时间内进入大量log，并且迟迟发不到服务器上，我们可以判断哪里出了问题，在这之后的 log 暂时不处理了。
        // 但我们依然要告诉 DDLog 这个存进去了。
        return YES;
    }
    //利用 formatter 得到消息字符串，添加到缓存
    [_logMessagesArray addObject:[_logFormatter formatLogMessage:logMessage]];
    return YES;
}

- (void)db_save{

    //判断是否在 logger 自己的GCD队列中
    if (![self isOnInternalLoggerQueue])
        NSAssert(NO, @"db_saveAndDelete should only be executed on the internalLoggerQueue thread, if you're seeing this, your doing it wrong.");
//    如果缓存内没数据，啥也不做
    if ([_logMessagesArray count] == 0)
        return;
//    获取缓存中所有数据，之后将缓存清空
    NSArray *oldLogMessagesArray = [_logMessagesArray copy];
    _logMessagesArray = [NSMutableArray arrayWithCapacity:0];
//    用换行符，把所有的数据拼成一个大字符串
    
    NSMutableString* postStr = [[NSMutableString alloc] init];
    
    for (NSString* message in oldLogMessagesArray) {
        [postStr appendFormat:@"%@\n",message];
    }
    
//    NSString *logMessagesString = [oldLogMessagesArray componentsJoinedByString:@"\n"];
//    发送给咱自己服务器(自己实现了)
    
//    [self post:logMessagesString];
    NSLog(@"上传到服务器的log信息 == %@",postStr);
}

@end
