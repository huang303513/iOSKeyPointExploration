//
//  FirstViewController.m
//  隐式动画
//
//  Created by maiyun on 15/6/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UIView *layerView;

@property(nonatomic,strong)CALayer *colorLayer;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //create sublayer
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
    self.colorLayer.backgroundColor = [UIColor blueColor].CGColor;
    
    //add it to our view
    [self.layerView.layer addSublayer:self.colorLayer];
    
    
}

- (IBAction)changeColour:(id)sender {
    
    [self function1];
    
    //[self function2];
    
}


-(void)function1{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    
    
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;
    [CATransaction commit];
}

-(void)function2{
    [CATransaction begin];
    [CATransaction setAnimationDuration:1.0];
    //动画做完了以后旋转90度
    [CATransaction setCompletionBlock:^{
        CGAffineTransform transform = self.colorLayer.affineTransform;
        transform = CGAffineTransformRotate(transform, M_PI_2);
        self.colorLayer.affineTransform = transform;
    }];
    
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1].CGColor;

    
    
    [CATransaction commit];
}


@end
