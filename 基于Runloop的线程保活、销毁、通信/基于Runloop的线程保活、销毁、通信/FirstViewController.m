//
//  FirstViewController.m
//  基于Runloop的线程保活、销毁、通信
//
//  Created by huangchengdu on 17/5/9.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
//@property(nonatomic,weak)NSThread *thread;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)startThread:(id)sender {
    [self doTest];
}

-(void)doTest{
    __block NSThread *thread;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"当前线程:%@,主线程:%@",[NSThread currentThread],[NSThread mainThread]);
        NSLog(@"当前线程开始");
        //获取当前线程
        thread = [NSThread currentThread];
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        //为当前线程的当前runloop添加一个Port,防止线程没事干直接退出
        [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        //开始runloop
        [runloop runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"当前线程结束");
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSelector:@selector(recieveMsg) onThread:thread withObject:nil waitUntilDone:NO];
    });
}


- (void)recieveMsg
{
    NSLog(@"收到消息了，在这个线程：%@,主线程:%@",[NSThread currentThread],[NSThread mainThread]);
}

-(void)dealloc{
    NSLog(@"FirstViewController销毁");
}


@end
