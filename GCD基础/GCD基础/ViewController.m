//
//  ViewController.m
//  GCD基础
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
   
    //新建一个串行队列,第一个参数是队列名称，第二个参数对于串行队列必须为NULL或者DISPATCH_QUEUE_SERIAL
    dispatch_queue_t mySerialDispatchQueue = dispatch_queue_create("com.example.gcd.mySerialDispatchQueue", NULL);
    //创建一个并行队列，第一个参数是队列名称，第二个参数必须为
    dispatch_queue_t myConcurrentDispatchQueue = dispatch_queue_create("com.example.gcd.MyConcurrentDispatchQueue", DISPATCH_QUEUE_CONCURRENT);
    
    
    //当我们添加一个任务到队列以后马上释放他，并不会把队列删除，因为往队列中每添加一个任务都会对队列执行retain操作，执行结束以后release。知道最后一个队列执行结束以后，队列自动删除。
    dispatch_async(myConcurrentDispatchQueue, ^{
        NSLog(@"异步操作");
    });
    
    //在Deployment Info小于ios 6的项目来说， dispatch_queue_create函数生成的队列必须要手动释放。在这个版本以后，就是ARC自动释放了。
    //下面这个宏是SDK6.0以后引入的。
    #if !OS_OBJECT_USE_OBJC
    dispatch_release(mySerialDispatchQueue);
    dispatch_release(myConcurrentDispatchQueue);
    #endif
    //下面这个宏可以得到项目的最低部署SDK版本。
    __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000;
    
    
    
    
    //系统提供一个串行主队列，只在主线程上执行代码
    dispatch_queue_t mainDispathQueue = dispatch_get_main_queue();
    
    //调用系统提供的并行队列，总共有四个优先级，内核根据这四种队列的优先级执行里面的任务。
    dispatch_queue_t globalDispatchQueueHigh = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    

    //一般使用模式
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //在这里执行异步的处理
        
        //处理结束后，在主线程执行界面操作
        dispatch_async(dispatch_get_main_queue(), ^{
            //只能在主线程中执行的处理
        });
    });
    
    
    
    //通过dispatch_queue_create生成的队列的优先级都是DISPATCH_QUEUE_PRIORITY_DEFAULT一样的优先级
    //可以通过下面的函数设置队列的优先级
    dispatch_queue_t globalDispatchQueueBackground = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    //把第一个参数的优先级指定与第二个参数的优先级一样。如果第一个参数是系统提供的队列，则结果未确定
    dispatch_set_target_queue(mySerialDispatchQueue, globalDispatchQueueBackground);
    
    
    //如果将必须不可并行执行的处理追加到多个串行队列中。如果使用了dispatch_set_target_queue函数将目标指定为某一个串行队列，则可以防止处理并行执行。
    
    //在指定时间后追加任务到队列，主线程的RunLoop每隔1/60秒循环一次。
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 3ull * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        NSLog(@"至少等待3秒钟以后再执行");
    });
    
    dispatch_time_t nowtime = [self getDispatchTimeByDate:[NSDate date]];
    
}



//把一个NSDate类型转换为dispatch_time_t类型
-(dispatch_time_t) getDispatchTimeByDate:(NSDate *)date{
    NSTimeInterval interval;
    double second,subsecond;
    struct timespec time;
    dispatch_time_t milestone;
    
    interval  = [date timeIntervalSince1970];
    subsecond = modf(interval, &second);
    time.tv_sec = second;
    time.tv_nsec = subsecond * NSEC_PER_SEC;
    milestone = dispatch_walltime(&time, 0);
    
    return milestone;
    
}
@end
























