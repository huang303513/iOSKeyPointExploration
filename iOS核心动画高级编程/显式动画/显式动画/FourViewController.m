//
//  FourViewController.m
//  
//
//  Created by maiyun on 15/6/25.
//
//

#import "FourViewController.h"

@interface FourViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBezierPath *bezierPath = [[UIBezierPath alloc]init];
    [bezierPath moveToPoint:CGPointMake(0, 150)];
    [bezierPath addCurveToPoint:CGPointMake(300, 150) controlPoint1:CGPointMake(75, 0) controlPoint2:CGPointMake(225, 300)];
    
    CAShapeLayer *pathLayer = [[CAShapeLayer alloc]init];
    pathLayer.path = bezierPath.CGPath;
    pathLayer.fillColor = [UIColor clearColor].CGColor;
    pathLayer.strokeColor = [UIColor redColor].CGColor;
    pathLayer.lineWidth = 3.0f;
    [self.containerView.layer addSublayer:pathLayer];
    
    CALayer *colorLayer = [CALayer layer];
    colorLayer.frame = CGRectMake(0, 0, 64, 64);
    colorLayer.position = CGPointMake(0, 150);
    colorLayer.backgroundColor = [UIColor greenColor].CGColor;
    [self.containerView.layer addSublayer:colorLayer];
    
    
    //移动动画
    CAKeyframeAnimation *animation1 = [CAKeyframeAnimation  animation];
    animation1.keyPath = @"position";
    animation1.path = bezierPath.CGPath;
    animation1.rotationMode = kCAAnimationRotateAuto;
    
    //颜色渐变动画
    CABasicAnimation *animation2 = [CABasicAnimation animation];
    animation2.keyPath = @"backgroundColor";
    animation2.toValue = (__bridge id)[UIColor redColor].CGColor;
    
    
    //动画组
    CAAnimationGroup  *groupAnimation  = [CAAnimationGroup animation];
    groupAnimation.animations = @[animation1,animation2];
    groupAnimation.duration = 5.0;
    [colorLayer addAnimation:groupAnimation forKey:nil];

    
    
}


@end
