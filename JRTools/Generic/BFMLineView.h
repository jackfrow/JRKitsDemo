//
//  BFMLineView.h
//  BaiFuMei
//
//  Created by Peter Zhang on 15/5/7.
//  Copyright (c) 2015年 xbcx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BFMLineViewOrientation) {
    BFMLineViewOrientationHorizontal,
    BFMLineViewOrientationVertical
};

typedef NS_ENUM(NSUInteger, BFMLineViewAppearance) {
    BFMLineViewAppearanceSolid,
    BFMLineViewAppearanceDash,
    BFMLineViewAppearanceCenterGradient
};

@interface BFMLineView : UIView

@property (nonatomic, assign) BFMLineViewOrientation orientation;

@property (nonatomic, assign) BFMLineViewAppearance appearance;

@property (nonatomic, strong) UIColor *lineColor;
// 线宽，水平模式下是 self.height 垂直模式下是 self.width
@property (nonatomic, assign) CGFloat lineWidth;
// 线长
@property (nonatomic, assign) CGFloat lineLength;

@property (nonatomic, assign) CGFloat gradientSolidRatio; // Default to 0.5
@property (nonatomic, assign) CGFloat gradientEmptyRation; // Default to 0.0

- (instancetype)initWithOrientation:(BFMLineViewOrientation)orientation
                              width:(CGFloat)width
                             length:(CGFloat)length;

@end
