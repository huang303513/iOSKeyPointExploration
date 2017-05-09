//
//  ThirdViewController.m
//  基于Runloop的线程保活、销毁、通信
//
//  Created by huangchengdu on 17/5/9.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()<NSMachPortDelegate>

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)sendMessage:(id)sender {
    NSMachPort *mainPort = [[NSMachPort alloc]init];
    NSPort *threadPort = [NSMachPort port];
    threadPort.delegate = self;
    
    [[NSRunLoop currentRunLoop] addPort:mainPort forMode:NSDefaultRunLoopMode];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程开始");
        [[NSRunLoop currentRunLoop] addPort:threadPort forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        NSLog(@"线程结束");
    });
    
    NSString *s1 = @"huangchengdu";
    NSData *data = [s1 dataUsingEncoding:NSUTF8StringEncoding];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableArray *array = [NSMutableArray arrayWithObjects:mainPort,data,nil];
        NSLog(@"发送消息");
        [threadPort sendBeforeDate:[NSDate date] msgid:1000 components:array from:mainPort reserved:0];
    });
}


#pragma mark 代理方法

-(void)handleMachMessage:(void *)msg{
    NSLog(@"收到消息了，线程为：%@",[NSThread currentThread]);
    NSLog(@"msg = %d",msg);
    //只能用KVC的方式取值
//    NSArray *array = [message valueForKeyPath:@"components"];
//    
//    NSData *data =  array[1];
//    NSString *s1 = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"消息值是:%@",s1);
    
    //    NSMachPort *localPort = [message valueForKeyPath:@"localPort"];
    //    NSMachPort *remotePort = [message valueForKeyPath:@"remotePort"];
}


@end
