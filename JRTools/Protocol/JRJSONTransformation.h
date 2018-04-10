//
//  JRJSONTransformation.h
//  JRKits
//
//  Created by jackfrow on 2018/4/10.
//  Copyright © 2018年 Jabber. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol JRJSONTransformation <NSObject>

@required

+ (instancetype)modelWithJSONObject:(id)jsonObject;

- (void)updateWithJSONObject:(id)jsonObject;

- (id)mutableJSONObject;

@optional

@property (nonatomic, strong) NSDate *recentUpdateDate;

- (BOOL)shouldNeedsUpdate;

+ (NSArray *)modelsWithJsonObjects:(NSArray *)jsonObjects;

@end
