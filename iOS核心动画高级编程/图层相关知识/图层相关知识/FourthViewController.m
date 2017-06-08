//
//  FourthViewController.m
//  图层相关知识
//
//  Created by 黄成都 on 15/6/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "FourthViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface FourthViewController ()
@property(nonatomic,strong)UIView *layerView;
@property(nonatomic,strong)CALayer *blueLayer;
@end

@implementation FourthViewController
@synthesize blueLayer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    UIView *layerView = [[UIView alloc]init];
    layerView.backgroundColor = [UIColor whiteColor];
    layerView.bounds = CGRectMake(0, 0, 200, 200);
    layerView.center = self.view.center;
    [self.view addSubview:layerView];
    self.layerView = layerView;
    
    
    blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.delegate = self;
    [self.layerView.layer addSublayer:blueLayer];
    //调用代理方法绘制图像
    [blueLayer display];
    
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    //绘制一个红色的圆圈
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
