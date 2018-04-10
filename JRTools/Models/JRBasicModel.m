//
//  JRBasicModel.m
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRBasicModel.h"
#import <objc/runtime.h>

@implementation JRBasicModel


-(id)copyWithZone:(NSZone *)zone{
    
    JRBasicModel *model = [[[self class] allocWithZone:zone] init];
    model.identifier = self.identifier;
    return model;

}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    if ([object isKindOfClass:[self class]] &&
        [self.identifier isEqualToString:((JRBasicModel *)object).identifier]) {
        return YES;
    }
    return NO;
}

#pragma mark - NSCoding Related Methods

- (NSArray *)propertiesNames
{
    // Check for a cached value (we use _cmd as the cache key,
    // which represents @selector(propertiesNames))
    NSMutableArray *array = objc_getAssociatedObject([self class], _cmd);
    if (array) {
        return array;
    }
    
    // Loop through our superclasses until we hit NSObject
    array = [NSMutableArray array];
    Class subclass = [self class];
    while (subclass != [NSObject class]) {
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(subclass, &propertyCount);
        for (int i = 0; i < propertyCount; i++) {
            // Get property name
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            NSString *key = @(propertyName);
            
            // Check if there is a backing ivar
            char *ivar = property_copyAttributeValue(property, "V");
            if (ivar) {
                // Check if ivar has KVC-compliant name
                NSString *ivarName = @(ivar);
                if ([ivarName isEqualToString:key] ||
                    [ivarName isEqualToString:[@"_" stringByAppendingString:key]]) {
                    // setValue:forKey: will work
                    [array addObject:key];
                }
                free(ivar);
            }
        }
        free(properties);
        subclass = [subclass superclass];
    }
    
    // Cache and return array
    objc_setAssociatedObject([self class], _cmd, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return array;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        for (NSString *propertyName in [self propertiesNames]) {
            id value = [aDecoder decodeObjectForKey:propertyName];
            if (value) [self setValue:value forKey:propertyName];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    for (NSString *propertyName in [self propertiesNames]) {
        id value = [self valueForKey:propertyName];
        [aCoder encodeObject:value forKey:propertyName];
    }
}

@end
