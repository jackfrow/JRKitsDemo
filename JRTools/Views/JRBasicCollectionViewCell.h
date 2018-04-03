//
//  JRBasicCollectionViewCell.h
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRModelAttach.h"

@interface JRBasicCollectionViewCell : UICollectionViewCell<JRModelAttach>


/**
 将cell高度的计算放到cell自己内部
 */
+ (CGSize)cellSizeWithModel:(JRBasicModel *)model atIndexPath:(NSIndexPath *)indexPath targetSize:(CGSize)targetSize;

@end
