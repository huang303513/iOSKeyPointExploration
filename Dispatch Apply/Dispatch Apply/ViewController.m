//
//  ViewController.m
//  Dispatch Apply
//
//  Created by 黄成都 on 15/6/14.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self test_dispatch_semaphore];
    [self test_dispatch_apply];
    
    
    
}


-(void)test_dispatch_io{
    dispatch_fd_t fd;
    dispatch_queue_t pipe_q = dispatch_queue_create("pipeQ", DISPATCH_QUEUE_SERIAL);
    dispatch_io_t pipe_channel = dispatch_io_create(DISPATCH_IO_STREAM, fd, pipe_q, ^(int error) {
        close(fd);
    });
    //fdpir[1];

}

/**
 *
 1创建一个信号量。参数指定信号量的起始值。这个数字是你可以访问的信号量，不需要有人先去增加它的数量。（注意到增加信号量也被叫做发射信号量）。译者注：这里初始化为0，也就是说，有人想使用信号量必然会被阻塞，直到有人增加信号量。
 2在 Completion Block 里你告诉信号量你不再需要资源了。这就会增加信号量的计数并告知其他想使用此资源的线程。
 3这会在超时之前等待信号量。这个调用阻塞了当前线程直到信号量被发射。这个函数的一个非零返回值表示到达超时了。在这个例子里，测试将会失败因为它以为网络请求不会超过 10 秒钟就会返回——一个平衡点！
 */
#warning 这个方法的理解好像有问题
- (void)downloadImageURLWithString:(NSString *)URLString
{
    // 1
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 2
        sleep(10);
        NSLog(@"不需要信号量了1111");
        dispatch_semaphore_signal(semaphore);
    }];
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 2
        NSLog(@"不需要信号量了2222");
        dispatch_semaphore_signal(semaphore);
    }];
    // 3
    dispatch_time_t timeoutTime = dispatch_time(DISPATCH_TIME_NOW, 50);
    if (dispatch_semaphore_wait(semaphore, timeoutTime)) {
        NSLog(@"可以了");
    }
}

-(void)test_dispatch_semaphore{
//    //dispatch_semaphore的计数为0时等待，计数大于等于1时不等待减一
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
//    
//    //等待直到dispatch_semaphore大于等于1,这里会阻塞当前线程。直到返回
//    long result = dispatch_semaphore_wait(semaphore, time);
//    if (result == 0) {
//        //此时信号量大于等于1，可以执行需要进行的排他控制的处理，同时信号量减一
//    }else{
//        //到达指定时间以后，此时信号量等于0，
//    }

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i < 10000; ++i) {
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//信号量减一
            [array addObject:[NSNumber numberWithInt:i]];
            dispatch_semaphore_signal(semaphore);//信号量加一
        });
    }
    NSLog(@"%@",array);
    
}






-(void)test_dispatch_suspend
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //dispatch_suspend挂起指定的queue
    dispatch_suspend(queue);
    //dispatch_resume恢复指定的queue
    dispatch_resume(queue);

}



-(void)test_dispatch_apply{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //把指定的任务执行指定次数，直到执行完毕才函数才返回。
    dispatch_apply(10, queue, ^(size_t index) {
        // NSLog(@"%zu",index);
    });
    //=================================================
    //因为dispatch_apply是同步函数，所以推荐在非同步函数中使用这个方法
    NSArray *array = @[@"q",@"w",@"e",@"r"];
    dispatch_async(queue, ^{
        dispatch_apply([array count], queue, ^(size_t index) {
            NSLog(@"%zu: %@",index,[array objectAtIndex:index]);
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Done11111");
        });
        
    });
    NSLog(@"Done");
    
    //    2015-06-14 08:02:50.559 Dispatch Apply[599:13019] 1: w
    //    2015-06-14 08:02:50.559 Dispatch Apply[599:12946] Done
    //    2015-06-14 08:02:50.559 Dispatch Apply[599:13018] 2: e
    //    2015-06-14 08:02:50.559 Dispatch Apply[599:13016] 0: q
    //    2015-06-14 08:02:50.559 Dispatch Apply[599:13025] 3: r
    //    2015-06-14 08:02:50.565 Dispatch Apply[599:12946] Done111

}


@end
