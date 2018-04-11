//
//  JRBasicTableViewCell.h
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRModelAttach.h"
#import "BFMLineView.h"

@interface JRBasicTableViewCell : UITableViewCell<JRModelAttach>

@property (nonatomic, readonly) BFMLineView *separatorView;

// Frame Layout 的 Cell 的子类重写本方法实现高度的计算。Auto Layout 由 JRBasicTableViewCell 自动完成。
+ (CGFloat)cellHeightWithModel:(JRBasicModel *)model contentWidth:(CGFloat)contentWidth;

@property (nonatomic, assign) UIEdgeInsets separatorViewInsets;


@end
