//
//  FirstViewController.m
//  动画缓冲
//
//  Created by 黄成都 on 15/6/28.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (nonatomic, strong) CALayer *colorLayer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 100, 100);
    self.colorLayer.position = CGPointMake(self.view.bounds.size.width / 2.0,self.view.bounds.size.height / 2.0);
    self.colorLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:self.colorLayer];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    self.colorLayer.position = [[touches anyObject] locationInView:self.view];
    [CATransaction commit];
}


@end
