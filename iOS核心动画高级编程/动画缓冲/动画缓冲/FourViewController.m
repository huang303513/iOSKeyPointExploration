//
//  FourViewController.m
//  动画缓冲
//
//  Created by 黄成都 on 15/6/28.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建系统时间函数
    //CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //自定义时间函数
    CAMediaTimingFunction *function = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
    
    CGPoint controlPoint1,controlPoint2;
    //得到时间控制函数的两个控制点
    [function getControlPointAtIndex:1 values:(float *)&controlPoint1];
    [function getControlPointAtIndex:2 values:(float *)&controlPoint2];
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointZero];
    [path  addCurveToPoint:CGPointMake(1, 1) controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    //设置可见区域大小
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    
    //创建shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.layerView.layer addSublayer:shapeLayer];
    
    //设置layer的起点为左下角
    self.layerView.layer.geometryFlipped = YES;
    
}


@end
