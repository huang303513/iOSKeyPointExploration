//
//  SevenViewController.m
//  显式动画
//
//  Created by maiyun on 15/6/26.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "SevenViewController.h"

@interface SevenViewController ()

@end

@implementation SevenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)performTransition:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, YES, 0.0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *converImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIView *coverView = [[UIImageView alloc]initWithImage:converImage];
    coverView.frame = self.view.bounds;
    [self.view addSubview:coverView];
    
    
    CGFloat red = arc4random()/(CGFloat)INT_MAX;
    CGFloat green = arc4random()/(CGFloat)INT_MAX;
    CGFloat blue = arc4random()/(CGFloat)INT_MAX;
    self.view.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    //执行动画
    [UIView animateWithDuration:1.0 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeScale(0.01, 0.01);
        transform = CGAffineTransformRotate(transform, M_PI_2);
        coverView.transform = transform;
        coverView.alpha = 0;

    } completion:^(BOOL finished) {
        [coverView removeFromSuperview];
    }];
    
    
    
    
}

@end
