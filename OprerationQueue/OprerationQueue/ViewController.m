//
//  ViewController.m
//  OprerationQueue
//
//  Created by 黄成都 on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//



#import "ViewController.h"
#import "HCDCreateInvocationOperation.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //invocationOperation
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
