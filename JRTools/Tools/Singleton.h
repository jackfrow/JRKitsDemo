/**
 提示：如果是MRC程序，请粘贴以下代码
 
 #if !__has_feature(objc_arc)
 - (oneway void)release { }
 - (id)autorelease { return _instance; }
 - (id)retain { return _instance; }
 - (NSUInteger)retainCount { return UINT32_MAX; }
 #endif
 */
// 1. 替换.h中的内容
#define singletonInterface(className)      + (instancetype)shared##className;

// 2. 替换.m中的内容
#define singletonImplementation(className) \
static className *_instance; \
+ (instancetype)shared##className { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [[self alloc] init]; \
    }); \
    return _instance; \
} \
+ (id)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        _instance = [super allocWithZone:zone]; \
    }); \
    return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
    return _instance; \
}

// 提示最后一行不要使用 \
