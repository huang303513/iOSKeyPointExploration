//
//  SecondViewController.m
//  图层时间
//
//  Created by 黄成都 on 15/6/28.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property(nonatomic,strong)CALayer *doorLayer;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *doorLayer = [CALayer layer];
    doorLayer.frame = CGRectMake(0, 0, 128, 256);
    doorLayer.position = CGPointMake(150 - 64, 150);
    doorLayer.anchorPoint = CGPointMake(0, 0.5);
    doorLayer.contents = (__bridge id)[UIImage imageNamed:@"Door.png"].CGImage;
    [self.containerView.layer addSublayer:doorLayer];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/500.0;
    self.containerView.layer.sublayerTransform = perspective;
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]init];
    [pan addTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    self.doorLayer.speed = 0.0;
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
//    animation.repeatDuration = INFINITY;
//    animation.autoreverses = YES;
    [doorLayer addAnimation:animation forKey:nil];

}

-(void)pan:(UIPanGestureRecognizer *)pan{
    CGFloat x = [pan translationInView:self.view].x;
    x /=200.0f;
    
    CFTimeInterval timeoffset = self.doorLayer.timeOffset;
    timeoffset = MIN(0.999, MAX(0.0, timeoffset - x));
    self.doorLayer.timeOffset = timeoffset;
    
    [pan setTranslation:CGPointZero inView:self.view];
}

@end
