//
//  HCDCircleLayer.m
//  Loading动画的实现
//
//  Created by 黄成都 on 15/12/27.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HCDCircleLayer.h"
#import <UIKit/UIKit.h>
static CGFloat const kLineWidth = 6;

@implementation HCDCircleLayer
@dynamic progress;


+(BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"progress"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(void)drawInContext:(CGContextRef)ctx{
    UIBezierPath *path = [UIBezierPath bezierPath];
    //半径
    CGFloat radius = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2 - kLineWidth/2;
    //中心
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    //头头
    CGFloat originStart = M_PI * 7 / 2;
    CGFloat originEnd = M_PI * 2;
    CGFloat currentOrigin = originStart - (originStart - originEnd) * self.progress;
    
    //尾巴
    CGFloat destStart = M_PI * 3;
    CGFloat destEnd = 0;
    CGFloat currentDest = destStart - (destStart - destEnd) * self.progress;
    //设置曲线路径
    [path addArcWithCenter:center radius:radius startAngle:currentOrigin endAngle:currentDest clockwise:NO];
    //把路径添加到当前上下文
    CGContextAddPath(ctx, path.CGPath);
    //宽度线条
    CGContextSetLineWidth(ctx, kLineWidth);
    //设置颜色
    CGContextSetStrokeColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
    CGContextStrokePath(ctx);
    
}
@end
