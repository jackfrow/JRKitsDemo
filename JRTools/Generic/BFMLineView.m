//
//  BFMLineView.m
//  BaiFuMei
//
//  Created by Peter Zhang on 15/5/7.
//  Copyright (c) 2015年 xbcx. All rights reserved.
//

#import "BFMLineView.h"

@implementation BFMLineView

- (instancetype)initWithOrientation:(BFMLineViewOrientation)orientation width:(CGFloat)width length:(CGFloat)length
{
    CGSize size = (orientation == BFMLineViewOrientationHorizontal) ? CGSizeMake(length, width) : CGSizeMake(width, length);
    self = [self initWithFrame:CGRectMake(0.0, 0.0, size.width, size.height)];
    if (self) {
        _gradientEmptyRation = 0.0;
        _gradientSolidRatio = 0.5;
        _orientation = orientation;
        _lineWidth = width;
        _lineLength = length;
        _lineColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setAppearance:(BFMLineViewAppearance)appearance
{
    _appearance = appearance;
    
    [self setNeedsDisplay];
}

- (void)setOrientation:(BFMLineViewOrientation)orientation
{
    if (_orientation != orientation) {
        _orientation = orientation;
        
        [self setNeedsDisplay];
        self.frame = ({
            CGRect frame = self.frame;
            if (orientation == BFMLineViewOrientationHorizontal)
                frame.size = CGSizeMake(self.lineLength, self.lineWidth);
            else
                frame.size = CGSizeMake(self.lineWidth, self.lineLength);
            frame;
        });
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    if (![_lineColor isEqual:lineColor] && _lineColor != lineColor) {
        _lineColor = lineColor;
        [self setNeedsDisplay];
    }
}

- (void)setLineLength:(CGFloat)lineLength
{
    if (_lineLength != lineLength) {
        _lineLength = lineLength;
        
        [self setNeedsDisplay];
        self.frame = ({
            CGRect frame = self.frame;
            if (self.orientation == BFMLineViewOrientationHorizontal) frame.size.width = lineLength;
            else frame.size.height = lineLength;
            frame;
        });
    }
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    if (_lineWidth != lineWidth) {
        _lineWidth = lineWidth;
        
        [self setNeedsDisplay];
        self.frame = ({
            CGRect frame = self.frame;
            if (self.orientation == BFMLineViewOrientationHorizontal) frame.size.height = lineWidth;
            else frame.size.width = lineWidth;
            frame;
        });
    }
}

- (void)setFrame:(CGRect)frame
{
    _lineWidth = (self.orientation == BFMLineViewOrientationHorizontal) ? CGRectGetHeight(frame) : CGRectGetWidth(frame);
    _lineLength = (self.orientation == BFMLineViewOrientationHorizontal) ? CGRectGetWidth(frame) : CGRectGetHeight(frame);
    [super setFrame:frame];
}

- (void)drawRadialGradientWithContext:(CGContextRef)context beginColor:(UIColor *)color
{
    CGFloat r, g ,b, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    CGFloat colors[] = {
        r, g, b, a,
        r, g, b, 0.0
    };
    CGFloat locations[] = { 0.0, 1.0 };
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, 2);
    
    CGFloat actualLength = (self.orientation == BFMLineViewOrientationHorizontal) ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds);
    CGFloat startRadius = ceilf(MIN(1.0, self.gradientSolidRatio) * actualLength) / 2.0,
    endRadius = (actualLength / 2.0) * MIN(1.0, (1 - self.gradientEmptyRation));
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    CGContextDrawRadialGradient(context, gradient, center,
                                startRadius, center, endRadius,
                                kCGGradientDrawsBeforeStartLocation);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

- (void)drawLineWithContext:(CGContextRef)context withColor:(UIColor *)color
{
    CGFloat centerWidth = self.lineWidth / 2.0;
    CGFloat actualLength = (self.orientation == BFMLineViewOrientationHorizontal) ? CGRectGetWidth(self.bounds) : CGRectGetHeight(self.bounds);
    CGPoint startPoint = (self.orientation == BFMLineViewOrientationHorizontal) ? CGPointMake(0.0, centerWidth) : CGPointMake(centerWidth, 0.0);
    CGPoint endPoint = (self.orientation == BFMLineViewOrientationHorizontal) ? CGPointMake(actualLength, centerWidth) : CGPointMake(centerWidth, actualLength);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    if (self.appearance == BFMLineViewAppearanceDash) {
        CGFloat pattern[] = {2, 2};
        CGContextSetLineDash(context, 1, pattern, 2);
    }
    CGContextStrokePath(context);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *color = self.lineColor ?: [UIColor lightGrayColor];
    
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    if (self.appearance == BFMLineViewAppearanceCenterGradient)
        [self drawRadialGradientWithContext:context beginColor:color];
    else
        [self drawLineWithContext:context withColor:color];
}

@end
