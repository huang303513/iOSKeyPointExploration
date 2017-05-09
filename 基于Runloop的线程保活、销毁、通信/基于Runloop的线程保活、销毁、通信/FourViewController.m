//
//  FourViewController.m
//  基于Runloop的线程保活、销毁、通信
//
//  Created by huangchengdu on 17/5/9.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "FourViewController.h"

//此输入源需要处理的后台事件
static void fire(void* info){
    
    NSLog(@"我现在正在处理后台任务");
    
    printf("%s",info);
}

@interface FourViewController ()
{
    CFRunLoopRef _runLoopRef;
    CFRunLoopSourceRef _source;
    CFRunLoopSourceContext _source_context;
}
@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)clickButton:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"线程开始");
        
        _runLoopRef = CFRunLoopGetCurrent();
        //初始化_source_context。
        bzero(&_source_context, sizeof(_source_context));
        //这里创建了一个基于事件的源，绑定了一个函数
        _source_context.perform = fire;
        //参数
        _source_context.info = "你好";
        //创建一个source
        _source = CFRunLoopSourceCreate(NULL, 0, &_source_context);
        //将source添加到当前RunLoop中去
        CFRunLoopAddSource(_runLoopRef, _source, kCFRunLoopDefaultMode);
        
        //开启runloop 第三个参数设置为YES，执行完一次事件后返回
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 9999999, YES);
        
        NSLog(@"线程结束");
    });
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (CFRunLoopIsWaiting(_runLoopRef)) {
            NSLog(@"RunLoop 正在等待事件输入");
            //添加输入事件
            CFRunLoopSourceSignal(_source);
            //唤醒线程，线程唤醒后发现由事件需要处理，于是立即处理事件
            CFRunLoopWakeUp(_runLoopRef);
        }else {
            NSLog(@"RunLoop 正在处理事件");
            //添加输入事件，当前正在处理一个事件，当前事件处理完成后，立即处理当前新输入的事件
            CFRunLoopSourceSignal(_source);
        }
    });
    
}


@end
