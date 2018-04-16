//
//  DomainModel.h
//  JRKits
//
//  Created by 徐方豪 on 2018/4/12.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRBasicModel.h"

@interface DomainModel : JRBasicModel

//**主域名*/
@property (nonatomic,copy) NSString* mainDomain;

/**名字*/
@property (nonatomic,copy) NSString* name;

@end

