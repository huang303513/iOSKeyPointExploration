//
//  ViewController.m
//  仿百度外卖下拉刷新的果冻效果
//
//  Created by huangchengdu on 16/1/5.
//  Copyright © 2016年 huangchengdu. All rights reserved.
//

#warning 参考博客地址：http://www.jianshu.com/p/21db20189c40

#import "ViewController.h"
#import "HCDCuteView.h"
#import "CommonTool.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HCDCuteView *cuteView = [[HCDCuteView alloc]initWithFrame:self.view.bounds];
    cuteView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:cuteView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
