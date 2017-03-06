//
//  ViewController.m
//  Memory Graph解决闭包引用
//
//  Created by huangchengdu on 17/3/6.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "ViewController.h"
#import "MyView.h"
@interface ViewController ()
@property(nonatomic,strong)MyView *myview;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    typeof(self) __weak weakself = self;
    //使用weakself和self看不同情况
    self.myview = [[MyView alloc]initWithBlock:^{
        [weakself textInputMode ];
    }];
}

-(void)testMethod{
    self.label.text = @"哈哈";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
