//
//  RefreshLayer.m
//  RefreshAnimation
//
//  Created by 宫城 on 15/12/29.
//  Copyright © 2015年 宫城. All rights reserved.
//

#import "RefreshLayer.h"

#define kLineLength  10
#define kArrowLength 5
#define kArrowAngle  M_PI/6

#define kCenterX    CGRectGetWidth(self.frame)/2
#define kCenterY    CGRectGetHeight(self.frame)/2

@implementation RefreshLayer

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    
    UIGraphicsPushContext(ctx);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // left line
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    leftPath.lineWidth = 2.0;
    leftPath.lineCapStyle = kCGLineCapRound;
    leftPath.lineJoinStyle = kCGLineJoinRound;
    
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    
    if (self.progress <= 0.5) {
        CGPoint leftA = CGPointMake(kCenterX - kLineLength, kCenterY + 2*kLineLength - self.progress/0.5*kLineLength);
        CGPoint leftB = CGPointMake(leftA.x, leftA.y - kLineLength);
        
        [leftPath moveToPoint:leftA];
        [leftPath addLineToPoint:leftB];
        
        [arrowPath moveToPoint:leftB];
        [arrowPath addLineToPoint:CGPointMake(leftB.x - kArrowLength*sin(kArrowAngle), leftB.y + kArrowLength*cos(kArrowAngle))];
        [leftPath appendPath:arrowPath];
    }else if (self.progress > 0.5) {
        CGPoint leftA = CGPointMake(kCenterX - kLineLength, kCenterY + kLineLength - (self.progress - 0.5)/0.5*kLineLength);
        CGPoint leftB = CGPointMake(kCenterX - kLineLength, kCenterY);
        
        [leftPath moveToPoint:leftA];
        [leftPath addLineToPoint:leftB];
        [leftPath addArcWithCenter:CGPointMake(kCenterX, kCenterY) radius:kLineLength startAngle:M_PI endAngle:M_PI+M_PI*(self.progress - 0.5)/0.5*9/10 clockwise:YES];
        
        [arrowPath moveToPoint:leftPath.currentPoint];
        [arrowPath addLineToPoint:CGPointMake(leftPath.currentPoint.x - kArrowLength*sin(kArrowAngle+M_PI*(self.progress - 0.5)/0.5*9/10), leftPath.currentPoint.y + kArrowLength*cos(kArrowAngle+M_PI*(self.progress - 0.5)/0.5*9/10))];
        [leftPath appendPath:arrowPath];
    }
    
    // right line
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    rightPath.lineWidth = 2.0;
    rightPath.lineCapStyle = kCGLineCapRound;
    rightPath.lineJoinStyle = kCGLineCapRound;
    
    if (self.progress <= 0.5) {
        CGPoint rightA = CGPointMake(kCenterX + kLineLength, kCenterY - 2*kLineLength + self.progress/0.5*kLineLength);
        CGPoint rightB = CGPointMake(rightA.x, rightA.y + kLineLength);
        
        [rightPath moveToPoint:rightA];
        [rightPath addLineToPoint:rightB];
        
        [arrowPath moveToPoint:rightB];
        [arrowPath addLineToPoint:CGPointMake(rightB.x + kArrowLength*sin(kArrowAngle), rightB.y - kArrowLength*cos(kArrowAngle))];
        [rightPath appendPath:arrowPath];
    }else if (self.progress > 0.5) {
        CGPoint rightA = CGPointMake(kCenterX + kLineLength, kCenterY - kLineLength + (self.progress - 0.5)/0.5*kLineLength);
        CGPoint rightB = CGPointMake(kCenterX + kLineLength, kCenterY);
        
        [rightPath moveToPoint:rightA];
        [rightPath addLineToPoint:rightB];
        [rightPath addArcWithCenter:CGPointMake(kCenterX, kCenterY) radius:kLineLength startAngle:0 endAngle:M_PI*(self.progress - 0.5)/0.5*9/10 clockwise:YES];
        
        [arrowPath moveToPoint:rightPath.currentPoint];
        [arrowPath addLineToPoint:CGPointMake(rightPath.currentPoint.x + kArrowLength*sin(kArrowAngle+M_PI*(self.progress - 0.5)/0.5*9/10), rightPath.currentPoint.y - kArrowLength*cos(kArrowAngle+M_PI*(self.progress - 0.5)/0.5*9/10))];
        [rightPath appendPath:arrowPath];
    }
    
    CGContextSaveGState(context);
    CGContextRestoreGState(context);
    
    [[UIColor blackColor] setStroke];
    [leftPath stroke];
    [rightPath stroke];
    [arrowPath stroke];
    
    UIGraphicsPopContext();
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    [self setNeedsDisplay];
}

@end
