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
    
    /**
     *  在默认情况下，operation 是同步执行的，也就是说在调用它的 start 方法的线程中执行它们的任务。而在 operation 和 operation queue 结合使用时，operation queue 可以为非并发的 operation 提供线程，只有自定义的并发operation是支持并发的。
     
     串行和并发的主要区别在于允许同时执行的任务数量。串行，指的是一次只能执行一个任务，必须等一个任务执行完成后才能执行下一个任务；并发，则指的是允许多个任务同时执行。
     
     只有第四种operaiton可以手动启动。
     */
    //================================================
    //[self FVC_excuteInvocationOperation];
    //================================================
    //[self FVC_excuteBlockOperation];
    //===========================================
    //[self FVC_excuteNonCurrentOperation];
    //==========================================
    [self FVC_executeCurrentOperation];
}

/**
 *  ，如果你想要手动地执行一个 operation ，又想这个 operation 能够异步执行的话，你需要做一些额外的配置来让你的 operation 支持并发执行。
 *
 *  @return nil
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
    //NSInvocationOperation *invocationOperationWithSelecter = [createInvocationOperation invocationOperationWithData:data userInput:@"myTaskMethod2"];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:invocationOperation];
    //[queue addOperation:invocationOperationWithSelecter];
    [queue addOperationWithBlock:^{
        NSLog(@"当前线程%@",[NSThread currentThread]);
    }];
    NSLog(@"NSInvocationOperation是异步执行");
}


@end
