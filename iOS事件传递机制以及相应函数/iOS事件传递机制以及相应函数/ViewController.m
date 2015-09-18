//
//  ViewController.m
//  iOS事件传递机制以及相应函数
//
//  Created by yifan on 15/9/18.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "LGFirstView.h"
#import "LGSecondView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LGFirstView *firstView = [[LGFirstView alloc] initWithFrame:CGRectMake(20, 200, 200, 200)];
    firstView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:firstView];
    
    LGSecondView *secondView = [[LGSecondView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
    secondView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.1];
    [self.view addSubview:secondView];
    
    //用户在LGSecondView上添加的视图点击效果是有的。
    UIButton *secndButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 130, 40, 20)];
    secndButton.backgroundColor  = [UIColor greenColor];
    [secndButton addTarget:self action:@selector(clickSecondCustomButton) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:secndButton];
}

-(void)clickSecondCustomButton{
    NSLog(@"点击了SecondView的Button");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
