//
//  NinethViewController.m
//  图层相关知识
//
//  Created by maiyun on 15/6/15.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "NinethViewController.h"

@interface NinethViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation NinethViewController


- (UIButton *)customButton
{
    //create button
    CGRect frame = CGRectMake(0, 0, 150, 50);
    UIButton *button = [[UIButton alloc] initWithFrame:frame];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 10;
    
    //add label
    frame = CGRectMake(20, 10, 110, 30);
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"Hello World";
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    
    return button;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //create opaque button
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(50, 150);
    [self.containerView addSubview:button1];
    
    //create translucent button
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(50, 250);
    button2.alpha = 0.5;
    [self.containerView addSubview:button2];
    //通过这个属性设置来解决视图与子视图透明度重叠问题；
    button2.layer.shouldRasterize = YES;
    //指定视图的分辨率
    button2.layer.rasterizationScale =[UIScreen mainScreen].scale;
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
