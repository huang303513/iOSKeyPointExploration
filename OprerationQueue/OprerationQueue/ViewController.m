//
//  ViewController.m
//  OprerationQueue
//
//  Created by 黄成都 on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//



#import "ViewController.h"
#import "HCDCreateInvocationOperation.h"
#import "HCDCreateBlockOperation.h"
#import "HCDNonConcurrentOperation.h"
#import "HCDConcurrentOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //================================================
    //[self FVC_excuteInvocationOperation];
    //================================================
    //[self FVC_excuteBlockOperation];
    //===========================================
    //[self FVC_excuteNonCurrentOperation];
    //==========================================
    [self FVC_executeCurrentOperation];
}
/*
 在默认情况下，operation 是同步执行的，也就是说在调用它的 start 方法的线程中执行它们的任务。而在 operation 和 operation queue 结合使用时，operation queue 可以为非并发的 operation 提供线程，因此，大部分的 operation 仍然可以异步执行。但是，如果你想要手动地执行一个 operation ，又想这个 operation 能够异步执行的话，你需要做一些额外的配置来让你的 operation 支持并发执行。
 */
#pragma mark 执行并发执行的operation,并且可以手动启动
- (void)FVC_executeCurrentOperation{
    HCDConcurrentOperation *currentOperation = [[HCDConcurrentOperation alloc]init];
    [currentOperation setCompletionBlock:^{
        NSLog(@"====完成了===");
    }];
    [currentOperation start];
     NSLog(@"自定义ConcurrentOperation实现异步执行");
}


#pragma mark 执行非并发执行的operation
- (void)FVC_excuteNonCurrentOperation{
    NSData *data = [@"hello world" dataUsingEncoding:NSUTF8StringEncoding];
    HCDNonConcurrentOperation *nonCurrentOpreation = [[HCDNonConcurrentOperation alloc]initWithData:data];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:nonCurrentOpreation];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程%@",[NSThread currentThread]);
    }];
    NSLog(@"自定义NonConcurrentOperation是异步执行");
}

#pragma mark 执行BlockOperation
- (void)FVC_excuteBlockOperation{
    HCDCreateBlockOperation *creatBlockOperation = [[HCDCreateBlockOperation alloc]init];
    NSBlockOperation *blockOperation = [creatBlockOperation blockOperation];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:blockOperation];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程%@",[NSThread currentThread]);
    }];
    NSLog(@"NSBlockOperation是异步执行");
}

#pragma mark 执行InvocationOperation
- (void)FVC_excuteInvocationOperation{
    HCDCreateInvocationOperation *createInvocationOperation = [[HCDCreateInvocationOperation alloc] init];
    
    NSData *data = [@"hello world" dataUsingEncoding:NSUTF8StringEncoding];
    NSInvocationOperation *invocationOperation = [createInvocationOperation invocationOperationWithData:data];
    NSInvocationOperation *invocationOperationWithSelecter = [createInvocationOperation invocationOperationWithData:data userInput:@"myTaskMethod2"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:invocationOperation];
    [queue addOperation:invocationOperationWithSelecter];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程%@",[NSThread currentThread]);
    }];
    NSLog(@"NSInvocationOperation是异步执行");
}


@end
