//
//  FirstViewController.m
//  显式动画
//
//  Created by maiyun on 15/6/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;
@property(strong,nonatomic)CALayer *colorLayer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50, 50, 100, 100);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}


- (IBAction)changeColour:(id)sender {
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    //新建一个动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)(color.CGColor);
    animation.delegate = self;
    [self.colorLayer addAnimation:animation forKey:nil];
}

-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}









@end
