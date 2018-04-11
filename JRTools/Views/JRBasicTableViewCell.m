//
//  JRBasicTableViewCell.m
//  JRKits
//
//  Created by 徐方豪 on 2018/4/2.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRBasicTableViewCell.h"
#import "UIView+Category.h"

static NSMutableDictionary *__calculatorCellsMap = nil;

@interface JRBasicTableViewCell()

@property (nonatomic, strong, readwrite) BFMLineView *separatorView;

@end

@implementation JRBasicTableViewCell
@synthesize model = _model;

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}


+ (CGFloat)cellHeightWithModel:(JRBasicModel *)model contentWidth:(CGFloat)contentWidth
{
    if ([self requiresConstraintBasedLayout]) {
        // Auto Layout cell height calculation.
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{ __calculatorCellsMap = [NSMutableDictionary new]; });
        
        NSString *className = NSStringFromClass(self);
        JRBasicTableViewCell *cell = __calculatorCellsMap[className];
        if (cell == nil) {
            NSString *nibPath = [[NSBundle mainBundle] pathForResource:className ofType:@"xib"];
            if (nibPath != nil)
                cell = [[NSBundle mainBundle] loadNibNamed:className owner:nil options:nil].firstObject;
            else
                cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bfm_calculator"];
            __calculatorCellsMap[className] = cell;
        }
        if (fabs(cell.frame.size.width - contentWidth) > 1e-3) {
            cell.frame = CGRectMake(0.0, 0.0, contentWidth, cell.frame.size.height);
        }
        cell.model = model;
        [cell setNeedsLayout];
        [cell layoutIfNeeded];
        CGSize fittingSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        return ceilf(fittingSize.height) + 1.0;
    }
    else {
        return 0.0;
    }
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addContent];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self addContent];
}


/**
 下划线
 */
-(void)addContent{
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundView.backgroundColor = [UIColor clearColor];
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.1];
    
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    self.separatorView = [[BFMLineView alloc] initWithOrientation:BFMLineViewOrientationHorizontal
                                                            width:0.5
                                                           length:self.contentView.width];
    self.separatorView.gradientSolidRatio = 0.05;
    self.separatorView.gradientEmptyRation = 0.1;
    self.separatorView.lineColor = [UIColor redColor];
    [self.contentView addSubview:self.separatorView];
}


- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    if (!self.separatorView.isHidden) {
        UIEdgeInsets insets = self.separatorViewInsets;
        self.separatorView.frame = CGRectMake(insets.left, self.contentView.height - self.separatorView.lineWidth - insets.bottom + insets.top, self.contentView.width - insets.left - insets.right, self.separatorView.height);
    }
}

@end
