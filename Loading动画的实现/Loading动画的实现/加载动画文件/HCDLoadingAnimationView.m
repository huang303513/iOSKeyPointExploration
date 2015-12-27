//
//  HCDLoadingAnimationView.m
//  Loading动画的实现
//
//  Created by 黄成都 on 15/12/27.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HCDLoadingAnimationView.h"
#import "HCDCircleLayer.h"
static NSString * const kName = @"name";

static CGFloat const kRadius = 40;
static CGFloat const kLineWidth = 6;
static CGFloat const kStep1Duration = 1.0;
static CGFloat const kStep2Duration = 3.0;

@interface HCDLoadingAnimationView()
@property(nonatomic,strong)HCDCircleLayer *acrToCircleLayer;
@end

@implementation HCDLoadingAnimationView
-(void)startAnimation{
    [self reset];
    
    [self doStep1];
}

#pragma mark 每次开始时都把原来的删除了
-(void)reset{
    [self.acrToCircleLayer removeFromSuperlayer];
}

//圆圈动画
-(void)doStep1{
    self.acrToCircleLayer = [HCDCircleLayer layer];
    self.acrToCircleLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:self.acrToCircleLayer];
    //设置圆圈大小
    self.acrToCircleLayer.bounds = CGRectMake(0, 0, kRadius * 2 + kLineWidth, kRadius * 2 + kLineWidth);
    //设置圆圈中心点
    self.acrToCircleLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    //设置属性值
    self.acrToCircleLayer.progress = 1;
    
    //给图层添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.duration = kStep1Duration;
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.delegate = self;
    //给动画设置一个属性
    [animation setValue:@"step1" forKey:kName];
    [self.acrToCircleLayer addAnimation:animation forKey:nil];

}

#pragma mark - animation step stop
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([[anim valueForKey:kName] isEqualToString:@"step1"]) {
        //[self doStep2];
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        animation.duration = kStep1Duration;
        animation.fromValue = @0.0;
        animation.toValue = @1.0;
        animation.delegate = self;
        //给动画设置一个属性
        [animation setValue:@"step1" forKey:kName];
        [self.acrToCircleLayer addAnimation:animation forKey:nil];

    }
}
@end
