//
//  ViewController.m
//  Loading动画的实现
//
//  Created by 黄成都 on 15/12/27.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "HCDLoadingAnimationView.h"

#warning  参考博客地址：http://www.jianshu.com/p/0dac1208a7ad
#warning 参考博客地址：http://www.jianshu.com/p/1c6a2de68753

@interface ViewController ()
@property(nonatomic,strong)HCDLoadingAnimationView *animationView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.animationView = [[HCDLoadingAnimationView alloc]init];
    self.animationView.bounds = CGRectMake(0, 0, 100, 100);
    self.animationView.center = self.view.center;
    self.animationView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.animationView];
 
    
}
#pragma mark 点击开始动画安妮；
- (IBAction)startAnimation:(id)sender {
    
    [self.animationView startAnimation];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
