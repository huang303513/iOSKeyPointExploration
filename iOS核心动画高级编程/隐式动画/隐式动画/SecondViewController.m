//
//  SecondViewController.m
//  隐式动画
//
//  Created by maiyun on 15/6/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@property(nonatomic,strong)CALayer *colorLayer;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
    
    //给layer添加一个自定义行为
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    //为图层的背景颜色添加行为
    self.colorLayer.actions = @{@"backgroundColor": transition};
    
}

- (IBAction)changeColour:(id)sender {
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    
}
@end
