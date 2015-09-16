//
//  ViewController.m
//  Dispatch Battier
//
//  Created by 黄成都 on 15/6/13.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test_dispatch_barrier_async];
    
}


-(void)test_dispatch_barrier_async{
    //通过dispatch_barrier_async实现对数据库或者文件系统的高效的读写
    dispatch_queue_t queue = dispatch_queue_create("com.example.gcd.ForBarrier", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"读取数据1");
    });
    dispatch_async(queue, ^{
        NSLog(@"读取数据2");
    });
    dispatch_async(queue, ^{
        NSLog(@"读取数据3");
    });
    dispatch_async(queue, ^{
        NSLog(@"读取数据4");
    });
    dispatch_async(queue, ^{
        NSLog(@"读取数据5");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"写入数据5");
    });
    dispatch_async(queue, ^{
        NSLog(@"读取数据6");
    });
    dispatch_async(queue, ^{
        NSLog(@"读取数据7");
    });

}

//同步队列。同步队列意味着当前线程会一直等待直到队列中的任务完成才返回
-(void)test_Dispatch_sync{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //阻塞当前线程知道任务完成
    dispatch_sync(queue, ^{
        NSLog(@"同步处理。。同步处理");
    });
    
    
    dispatch_queue_t mainqueue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        dispatch_sync(mainqueue, ^{//如果这里用同步，则会引起死锁。
            NSLog(@"hello");
        });
    });
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
