//
//  SecondViewController.m
//  基于Runloop的线程保活、销毁、通信
//
//  Created by huangchengdu on 17/5/9.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "SecondViewController.h"
static int count = 10;
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)startTimer:(id)sender {
    count = 10;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"线程开始");
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(doTimeTask:) userInfo:@{@"test":@"test"} repeats:YES];
        [timer fire];
        
        //把timer添加进入当前线程的runloop
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        /**
         当前runloop运行多久时间

         @ kCFRunLoopDefaultMode 其中第一个参数是指RunLoop运行的模式（例如kCFRunLoopDefaultMode或者kCFRunLoopCommonModes）
         @ 100 第二个参数是运行时间，可以把时间设置来小于10看是什么结果
         @ YES 第三个参数是是否在处理事件后让RunLoop退出返回
         @ 返回结果
         */
        SInt32 result = CFRunLoopRunInMode(kCFRunLoopDefaultMode, MAXFLOAT, YES);
        /*
         kCFRunLoopRunFinished = 1, //Run Loop结束，没有Timer或者其他Input Source
         kCFRunLoopRunStopped = 2, //Run Loop被停止，使用CFRunLoopStop停止Run Loop
         kCFRunLoopRunTimedOut = 3, //Run Loop超时
         kCFRunLoopRunHandledSource = 4 ////Run Loop处理完事件，注意Timer事件的触发是不会让Run Loop退出返回的，即使CFRunLoopRunInMode的第三个参数是YES也不行
         */
        switch (result) {
            case kCFRunLoopRunFinished:
                NSLog(@"kCFRunLoopRunFinished");
                
                break;
            case kCFRunLoopRunStopped:
                NSLog(@"kCFRunLoopRunStopped");
                
            case kCFRunLoopRunTimedOut:
                NSLog(@"kCFRunLoopRunTimedOut");
                
            case kCFRunLoopRunHandledSource:
                NSLog(@"kCFRunLoopRunHandledSource");
            default:
                break;
        }
        NSLog(@"线程结束");
    });
}


-(void)doTimeTask:(NSTimer *)timer{
    
    NSLog(@"第%d次调用",count);
    count--;
    if (count == 0) {
        [timer invalidate];
        timer = nil;
        NSLog(@"定时器结束");
    }
}

-(void)dealloc{
    NSLog(@"SecondViewController结束");
}

- (IBAction)invalitTimer:(id)sender {
    
}


@end
