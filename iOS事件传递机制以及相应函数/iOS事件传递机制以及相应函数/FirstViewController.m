//
//  FirstViewController.m
//  iOS事件传递机制以及相应函数
//
//  Created by huangchengdu on 17/5/10.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import "FirstViewController.h"
#import "WSView.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WSView *wsView = [[WSView alloc]init];
    wsView.frame = CGRectMake(50, 70, 150, 200);
    wsView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:wsView];
}



@end
