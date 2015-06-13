//
//  ViewController.m
//  Dispatch Group
//
//  Created by maiyun on 15/6/13.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    dispatch_queue_t queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk0");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"blk2");
    });
    //group中的所有任务都结束以后，才把开始执行这里的任务。group执行完以后才能把任务加入主队列
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"done");
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
