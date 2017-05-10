//
//  Observer.m
//  Notification与多线程以及Notification安全
//
//  Created by huangchengdu on 17/5/10.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import "Observer.h"
#import "Poster.h"



@implementation Observer
- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        

        //初始化一个Poster对象就会自动在非主线发送一个通知
        _poster = [[Poster alloc] init];
        
        /*
         notificationObserver不能为nil。
         notificationSelector回调方法有且只有一个参数(NSNotification对象)。
         如果notificationName为nil，则会接收所有的通知(如果notificationSender不为空，则接收所有来自于notificationSender的所有通知)。如代码清单1所示。
         如果notificationSender为nil，则会接收所有notificationName定义的通知；否则，接收由notificationSender发送的通知。
         监听同一条通知的多个观察者，在通知到达时，它们执行回调的顺序是不确定的，所以我们不能去假设操作的执行会按照添加观察者的顺序来执行
         */
        //这个对象为观察者、监听所有的通知

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:TEST_NOTIFICATION object:nil];
        
    }
    
    return self;
}


/**
 这个方法执行过程中，如果Observer对象被释放，则会奔溃

 @param notification 通知对象
 */
- (void)handleNotification:(NSNotification *)notification
{
    NSLog(@"handle notification begin");
    sleep(4);
    NSLog(@"handle notification end");
    //2017.5月份已经不奔溃了，貌似苹果改变了底层实现
    self.i = 10;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"Observer dealloc");
}
@end
