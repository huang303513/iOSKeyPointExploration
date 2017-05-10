//
//  ThirdViewController.m
//  iOS事件传递机制以及相应函数
//
//  Created by huangchengdu on 17/5/10.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import "ThirdViewController.h"
#import "LGFirstView.h"
#import "LGSecondView.h"

#warning 参考博文地址：http://www.superqq.com/blog/2015/04/23/iosyong-hu-dian-ji-shi-jian-chu-li/

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LGFirstView *firstView = [[LGFirstView alloc] initWithFrame:CGRectMake(20, 200, 200, 200)];
    firstView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:firstView];
    
    LGSecondView *secondView = [[LGSecondView alloc] initWithFrame:CGRectMake(20, 70, 200, 200)];
    secondView.backgroundColor = [UIColor redColor];
    secondView.alpha = 0.7;
    [self.view addSubview:secondView];
    
    //用户在LGSecondView上添加的视图点击效果是有的。
    UIButton *secndButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 120, 150, 40)];
    [secndButton setTitle:@"secondButton" forState:UIControlStateNormal];
    secndButton.backgroundColor  = [UIColor orangeColor];
    [secndButton addTarget:self action:@selector(clickSecondCustomButton) forControlEvents:UIControlEventTouchUpInside];
    [secondView addSubview:secndButton];
}

-(void)clickSecondCustomButton{
    NSLog(@"点击了SecondView的Button");
}

@end
