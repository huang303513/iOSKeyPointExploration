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
static NSString *const KBlockNotication = @"KBlockNotication";

@interface ViewController ()<NSMachPortDelegate>
@property (nonatomic) NSMutableArray    *notifications;         // 通知队列
@property (nonatomic) NSThread          *notificationThread;    // 期望线程
@property (nonatomic) NSLock            *notificationLock;      // 用于对通知队列加锁的锁对象，避免线程冲突
@property (nonatomic) NSMachPort        *notificationPort;      // 用于向期望线程发送信号的通信端口


@property(nonatomic,strong)NSString *name;
//Block类型的Operation
@property(nonatomic,strong)id blockOperation;
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
    
   // 每次调用addObserver时，都会在通知中心重新注册一次，即使是同一对象监听同一个消息，而不是去覆盖原来的监听。这样，当通知中心转发某一消息时，如果同一对象多次注册了这个通知的观察者，则会收到多个通知，
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(processNotification:) name:KFirstNotication object:nil];
    
    
    /*
     name和obj为nil时的情形与前面一个方法是相同的。
     如果queue为nil，则消息是默认在post线程中同步处理，即通知的post与转发是在同一线程中；但如果我们指定了操作队列，情况就变得有点意思了，我们一会再讲。
     block块会被通知中心拷贝一份(执行copy操作)，以在堆中维护一个block对象，直到观察者被从通知中心中移除。所以，应该特别注意在block中使用外部对象，避免出现对象的循环引用，这个我们在下面将举例说明。
     如果一个给定的通知触发了多个观察者的block操作，则这些操作会在各自的Operation Queue中被并发执行。所以我们不能去假设操作的执行会按照添加观察者的顺序来执行。
     该方法会返回一个表示观察者的对象，记得在不用时释放这个对象。
     */
    __weak typeof(self) weakSelf = self;
    self.blockOperation = [[NSNotificationCenter defaultCenter] addObserverForName:KBlockNotication object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.name = @"避免循环引用";
        NSLog(@"receive thread = %@", [NSThread currentThread]);
    }];
    
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
 通知线程安全处理。现在的情况是通知中心维持对象的引用从_unretain_unsafe改为weak，所以现在不会导致奔溃问题

 @param sender nil
 */
- (IBAction)clickButton2:(id)sender {
    
     __autoreleasing Observer *observer = [[Observer alloc] init];
}

- (IBAction)clickButton3:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"post thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:KBlockNotication object:nil];
    });
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

//在释放对象前，一定要记住如果它监听了通知，一定要将它从通知中心移除。如果是addObserverForName:object:queue:usingBlock:，也记得一定得移除这个匿名观察者。说白了就一句话，添加和移除要配对出现。
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:KBlockNotication object:nil];
}

@end
