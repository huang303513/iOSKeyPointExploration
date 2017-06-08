//
//  TenthViewController.m
//  图层旋转摆放扭曲等
//
//  Created by yifan on 15/9/6.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "TenthViewController.h"
@interface TenthViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation TenthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:emitter];
    
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width/2, emitter.frame.size.height/2);
    
    CAEmitterCell *cell = [[CAEmitterCell alloc]init];
    cell.contents = (__bridge id)([UIImage imageNamed:@"Spark.png"].CGImage);
    cell.birthRate = 150;
    cell.lifetime = 5.0;
    cell.color = [UIColor colorWithRed:0.5 green:0.1 blue:1.0 alpha:1].CGColor;
    cell.alphaSpeed = -0.4;
    cell.velocity = 50;
    cell.velocityRange = 50;
    cell.emissionRange = M_PI * 2.0;
    emitter.emitterCells = @[cell];
}

@end
