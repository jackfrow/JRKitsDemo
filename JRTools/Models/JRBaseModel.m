//
//  JRBaseModel.m
//  JRKits
//
//  Created by jackfrow on 2018/4/10.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRBaseModel.h"

@implementation JRBaseModel
@synthesize recentUpdateDate = _recentUpdateDate;

+ (instancetype)modelWithJSONObject:(id)jsonObject
{
    if (![jsonObject isKindOfClass:[NSDictionary class]]) return nil;
    
    JRBaseModel *model = self.new;
    [model updateWithJSONObject:jsonObject];
    return model;
}

- (void)updateWithJSONObject:(id)jsonObject
{
    // 子类实现 JSON 对象 -> Model 属性的转换
    if (jsonObject[@"id"]) self.identifier = [jsonObject[@"id"] description];
}

- (id)mutableJSONObject
{
    // 子类实现 Model 属性 -> 可变 JSON 对象的转变
    return nil;
}

- (BOOL)shouldNeedsUpdate
{
    return self.recentUpdateDate == nil || [[NSDate date] timeIntervalSinceDate:self.recentUpdateDate] > 600;
}

+ (NSArray *)modelsWithJsonObjects:(NSArray *)jsonObjects
{
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *json in jsonObjects) {
        if ([json isKindOfClass:[NSDictionary class]]) {
            [models addObject:[self modelWithJSONObject:json]];
        }
    }
    return models;
}

@end
