//
//  SecondViewController.m
//  图层旋转摆放扭曲等
//
//  Created by 黄成都 on 15/6/23.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个3D动画对象
    CATransform3D perspective = CATransform3DIdentity;
    //设置灭点
    perspective.m34 = -1.0/500.0;
    //让他的子视图有同样的灭点
    self.containerView.layer.sublayerTransform = perspective;
    //子视图一旋转45度
    CATransform3D transform1 = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    self.layerView1.layer.transform = transform1;
    
    CATransform3D transform2 = CATransform3DMakeRotation(-M_PI_4, 0, 1, 0);
    self.layerView2.layer.transform = transform2;
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
