//
//  DomainManagerVc.h
//  JRKits
//
//  Created by 徐方豪 on 2018/4/12.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DomainModel.h"

extern NSString* const JRDomain;

@interface DomainManagerVc : UIViewController

/**
 选择Domain地址成功回调
 */
@property (nonatomic, copy) void (^selectedSuceesBlock)(DomainModel *model);

@end
