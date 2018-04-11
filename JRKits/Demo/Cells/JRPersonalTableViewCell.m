//
//  JRPersonalTableViewCell.m
//  JRKits
//
//  Created by jackfrow on 2018/4/8.
//  Copyright © 2018年 Jabber. All rights reserved.
//

#import "JRPersonalTableViewCell.h"
#import "JRPersonalModel.h"

@interface JRPersonalTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;

@end

@implementation JRPersonalTableViewCell

#pragma mark - inherit
+ (CGFloat)cellHeightWithModel:(JRBasicModel *)model contentWidth:(CGFloat)contentWidth{
    
    return 100;
    
}

-(void)setModel:(JRBasicModel *)model{
    [super setModel:model];
    if ([model isMemberOfClass:[JRPersonalModel class]]) {
        JRPersonalModel *item = (JRPersonalModel *)model;
        self.NameLabel.text = item.name;
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
