//
//  HCDConcurrentOperation.m
//  OprerationQueue
//
//  Created by yifan on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDConcurrentOperation.h"

@interface HCDConcurrentOperation()

@end

@implementation HCDConcurrentOperation
@synthesize executing = _executing;
@synthesize finished = _finished;

- (instancetype)init{
    self = [super init];
    if (self) {
        _executing = NO;
        _finished = NO;
    }
    return self;
}

- (BOOL)isConcurrent{
    return YES;
}

- (BOOL)isExecuting{
    return _executing;
}
/**
 *  ，我们通过查看 NSOperation 类的头文件可以发现，executing 和 finished 属性都被声明成了只读的 readonly 。所以我们在 NSOperation 子类中就没有办法直接通过 setter 方法来自动触发 KVO 通知，这也是为什么我们需要在接下来的代码中手动触发 KVO 通知的原因。
 */
- (BOOL)isFinished{
    return _finished;
}

- (void)start{
    if (self.isCancelled) {
        //激活KVO
        [self willChangeValueForKey:@"isFinished"];
        _finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    _executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}
/**
 *  是真正执行任务的 main 方法，值得注意的是在任务执行完毕后，我们需要手动触动 isExecuting 和 isFinished 的 KVO 通知。
 */
- (void)main{
    @try {
        //NSLog(@"Start executing %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [NSThread mainThread], [NSThread currentThread]);
        
        //异步请求并不会阻塞操作的完成。。
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"网络异步请求结束");
            [self willChangeValueForKey:@"isExecuting"];
            _executing = NO;
            [self didChangeValueForKey:@"isExecuting"];
            
            [self willChangeValueForKey:@"isFinished"];
            _finished  = YES;//只有这个属性是YES以后，这个并发操作才算完成了。
            [self didChangeValueForKey:@"isFinished"];

        }];
        
        //同步请求会阻塞操作的完成。
        //        NSData *retureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]];
        //
        //        if (retureData) {
        //            NSLog(@"同步请求返回");
        //        }

    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        
    }
}

@end
