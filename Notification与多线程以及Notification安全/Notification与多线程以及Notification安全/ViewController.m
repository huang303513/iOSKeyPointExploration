//
//  ViewController.m
//  Notification与多线程以及Notification安全
//
//  Created by yifan on 15/9/15.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//



#import "ViewController.h"
#import "Observer.h"

static NSString *const KFirstNotication = @"KFirstNotication";

@interface ViewController ()<NSMachPortDelegate>
@property (nonatomic) NSMutableArray    *notifications;         // 通知队列
@property (nonatomic) NSThread          *notificationThread;    // 期望线程
@property (nonatomic) NSLock            *notificationLock;      // 用于对通知队列加锁的锁对象，避免线程冲突
@property (nonatomic) NSMachPort        *notificationPort;      // 用于向期望线程发送信号的通信端口

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"current thread = %@", [NSThread currentThread]);
    
    // 初始化
    self.notifications = [[NSMutableArray alloc] init];
    self.notificationLock = [[NSLock alloc] init];
    //通知处理线程，这里是主线程
    self.notificationThread = [NSThread currentThread];
    //可以使用端口来处理线程之间的通讯。
    self.notificationPort = [[NSMachPort alloc] init];
    self.notificationPort.delegate = self;
    
    // 给主线程添加端口事件的监听。只要是通过这个端口发送的事件，都会在主线程中处理。比如从这个端口中发送通知，也会在主线程处理
    // 当Mach消息到达而接收线程的run loop没有运行时，则内核会保存这条消息，直到下一次进入run loop
    [[NSRunLoop currentRunLoop] addPort:self.notificationPort
                                forMode:(__bridge NSString *)kCFRunLoopCommonModes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processNotification:) name:KFirstNotication object:nil];
    
}


/**
 通知在指定线程处理，这里只在主线程处理。

 @param sender nil
 */
- (IBAction)clickButton1:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //在非主线程发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:KFirstNotication object:nil userInfo:nil];
        
    });
}

/**
 通知线程安全处理

 @param sender nil
 */
- (IBAction)clickButton2:(id)sender {
    
     __autoreleasing Observer *observer = [[Observer alloc] init];
}



#pragma mark NSMachPortDelegate代理方法

/**
 一定是在主线程，因为是在主线程添加对这个端口消息的监听

 @param msg 消息
 */
-(void)handleMachMessage:(void *)msg{
    [self.notificationLock lock];
    
    while ([self.notifications count]) {
        NSNotification *notification = [self.notifications objectAtIndex:0];
        [self.notifications removeObjectAtIndex:0];
        [self.notificationLock unlock];
        //调用通知处理方法
        [self processNotification:notification];
        [self.notificationLock lock];
    };
    
    [self.notificationLock unlock];
}

- (void)processNotification:(NSNotification *)notification {
    //如果不是主线程，则通过notificationPort转换到主线程处理
    if ([NSThread currentThread] != _notificationThread) {
        // 如果当前线程不在要求的线程。转换到那个线程。
        [self.notificationLock lock];
        [self.notifications addObject:notification];
        [self.notificationLock unlock];
        //发送一条Mach消息、会调用代理方法
        [self.notificationPort sendBeforeDate:[NSDate date]
                                   components:nil
                                         from:nil
                                     reserved:0];
    }else {//在主线程，则直接处理消息
        // 处理通知
        NSLog(@"current thread = %@", [NSThread currentThread]);
        NSLog(@"process notification");
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
