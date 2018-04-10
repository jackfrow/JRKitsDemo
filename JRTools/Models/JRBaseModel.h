//
//  JRBaseModel.h
//  JRKits
//
//  Created by jackfrow on 2018/4/10.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRBasicModel.h"
#import "JRJSONTransformation.h"


/**
 用于一些特定情况,需要自己处理的model.
 */
@interface JRBaseModel : JRBasicModel<JRJSONTransformation>


@end
