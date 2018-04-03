//
//  JRBasicCollectionViewCell.m
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRBasicCollectionViewCell.h"

static NSMutableDictionary *__calculatorCollectionCellsMap = nil;

@implementation JRBasicCollectionViewCell
@synthesize model = _model;

+ (CGSize)cellSizeWithModel:(JRBasicModel *)model atIndexPath:(NSIndexPath *)indexPath targetSize:(CGSize)targetSize
{
    if ([self requiresConstraintBasedLayout]) {
        // Auto Layout cell height calculation.
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{ __calculatorCollectionCellsMap = [NSMutableDictionary new]; });
        
        NSString *className = NSStringFromClass(self);
        JRBasicCollectionViewCell *cell = __calculatorCollectionCellsMap[className];
        if (cell == nil) {
            NSString *nibPath = [[NSBundle mainBundle] pathForResource:className ofType:@"xib"];
            if (nibPath != nil)
                cell = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil].firstObject;
            else
                cell = [[self alloc] initWithFrame:CGRectMake(0.0, 0.0, 20.0, 20.0)];
            __calculatorCollectionCellsMap[className] = cell;
        }
        if (fabs(cell.frame.size.width - targetSize.width) > 1e-3 ||
            fabs(cell.frame.size.height - targetSize.height) > 1e-3) {
            cell.frame = CGRectMake(0.0, 0.0, targetSize.width, targetSize.height);
        }
        cell.model = model;
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        CGSize fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return CGSizeMake(ceilf(fittingSize.width) + 1.0, ceilf(fittingSize.height) + 1.0);
    }
    else {
        return CGSizeMake(44.0, 44.0);
    }
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
