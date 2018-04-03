//
//  JRBasicModel.h
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <YYModel.h>

/**
 实现yymodel协议，如果对象想要实现深度copy,只需调用YYCopy
 */
@interface JRBasicModel : NSObject<YYModel>

@end
