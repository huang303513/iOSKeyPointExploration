//
//  DrawDradualChangeView.m
//  
//
//  Created by maiyun on 15/6/17.
//
//

#import "DrawDradualChangeView.h"

@implementation DrawDradualChangeView

-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    self.backgroundColor = [UIColor greenColor];
    return self;
}

//绘画出渐变文档
-(void)drawRect:(CGRect)rect{
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(currentContext);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    UIColor *startColor = [UIColor orangeColor];
    CGFloat *startColorComponents = (CGFloat *)CGColorGetComponents([startColor CGColor]);
    UIColor *endColor = [UIColor blueColor];
    CGFloat *endColorComponents = (CGFloat *)CGColorGetComponents([endColor CGColor]);
    
    CGFloat colorComponents[8] = {
        startColorComponents[0],
        startColorComponents[1],
        startColorComponents[2],
        startColorComponents[3],
        endColorComponents[0],
        endColorComponents[1],
        endColorComponents[2],
        endColorComponents[3]
    };
    
    CGFloat colorIndices[2] = {
        0.0f,
        1.0f
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, (const CGFloat *)&colorComponents, (const CGFloat *)&colorIndices, 2);
    
    CGColorSpaceRelease(colorSpace);
    
    CGPoint startPoint,endPoint;
    startPoint = CGPointMake(120, 260);
    endPoint = CGPointMake(200.0f, 220);
    
    //CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    CGContextDrawLinearGradient(currentContext, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    
    CGContextRestoreGState(currentContext);
}


@end
