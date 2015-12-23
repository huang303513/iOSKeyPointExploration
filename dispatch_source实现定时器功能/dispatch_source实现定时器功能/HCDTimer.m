//
//  HCDTimer.m
//  dispatch_source实现定时器功能
//
//  Created by huangchengdu on 15/12/23.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#import "HCDTimer.h"

@interface HCDTimer ()
@property(nonatomic,readwrite,copy)dispatch_block_t block;
@property(nonatomic,readwrite,retain)dispatch_source_t source;
@end

@implementation HCDTimer

+(HCDTimer *)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds block:(dispatch_block_t)block{
    
    NSParameterAssert(seconds);
    NSParameterAssert(block);
    
    HCDTimer *timer = [[self alloc]init];
    timer.block = block;
    //设置一个定时器源，在祝队列中设置。
    timer.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    //定时间隔时间
    uint64_t nsec = (uint64_t)(seconds * NSEC_PER_SEC);
    //给定时器源设置一个时间，这个时间就是间隔执行的时间
    dispatch_source_set_timer(timer.source, dispatch_time(DISPATCH_TIME_NOW, nsec), nsec, 0);
    //给定时器源设置一个定时器触发时要执行的代码块
    dispatch_source_set_event_handler(timer.source, block);
    //开始定时器
    dispatch_resume(timer.source);
    return timer;
}

-(void)invalidate{
    if (self.source) {
        dispatch_source_cancel(self.source);
        self.source = nil;
    }
    self.block = nil;
}

-(void)dealloc{
    [self invalidate];
    NSLog(@"定时器被卸载了");
}

-(void)fire{
    self.block();
}

-(void)stopTimer{
    dispatch_suspend(self.source);
}
@end
