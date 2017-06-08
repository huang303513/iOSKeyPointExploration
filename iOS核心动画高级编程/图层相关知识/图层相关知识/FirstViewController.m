//
//  FirstViewController.m
//  图层相关知识
//
//  Created by 黄成都 on 15/6/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property(nonatomic,strong)UIView *layerView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    UIView *layerView = [[UIView alloc]init];
    layerView.backgroundColor = [UIColor whiteColor];
    layerView.bounds = CGRectMake(0, 0, 200, 200);
    layerView.center = self.view.center;
    [self.view addSubview:layerView];
    self.layerView = layerView;
    
    //======================================================
//    CALayer *blueLayer = [CALayer layer];
//    blueLayer.frame = CGRectMake(50, 50, 100, 100);
//    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
//    [self.layerView.layer addSublayer:blueLayer];
    //======================================================
    
    
    UIImage *image = [UIImage imageNamed:@"Snowman.png"];
    //拉伸图片适应图层
    self.layerView.layer.contentsGravity = kCAGravityCenter;
    //如果image.scale是2，那个就表示每个点放两个像素。
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    
    //当用代码的方式来处理寄宿图时，一定要记住手动设置图层的contentsScale属性。
    self.layerView.layer.contentsScale = [UIScreen mainScreen].scale;
    
    
    //截断超过视图大小的内容.uiview对应的事cliptobounds
    self.layerView.layer.masksToBounds = YES;
    
    
    
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
