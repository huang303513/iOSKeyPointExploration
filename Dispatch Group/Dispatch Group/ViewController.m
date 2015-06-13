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
    
    
    //
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);
    //这个函数用于判断经过指定时间以后，group里面的任务是否完成，如果完成，返回0，如果不等于0，则是没有完成。
    //这里的等待的意思是，当前线程会处于阻塞状态且dispatch_group_wait方法处于调用状态，知道group任务完成或者指定时间结束。
    long result = dispatch_group_wait(group, time);
    if (result == 0) {
        //属于Dispatch Group的全部处理执行结束
    }else{
        //属于Dispatch Group的有处理没有执行结束
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
