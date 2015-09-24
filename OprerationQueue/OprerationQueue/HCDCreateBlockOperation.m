//
//  HCDCreateBlockOperation.m
//  OprerationQueue
//
//  Created by yifan on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDCreateBlockOperation.h"

@implementation HCDCreateBlockOperation
- (NSBlockOperation *)blockOperation{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
       // NSLog(@"Start executing block1, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        //sleep(3);
        //NSLog(@"Finish executing block1");
        //异步请求并不会阻塞操作的完成。。
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"网络异步请求结束1");
            
        }];
        //同步请求会阻塞操作的完成。
//        NSData *retureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]];
//        
//        if (retureData) {
//            NSLog(@"同步请求返回1");
//        }

    }];
    [blockOperation addExecutionBlock:^{
        //NSLog(@"Start executing block2, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        //sleep(3);
        //NSLog(@"Finish executing block2");
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"网络异步请求结束2");
            
        }];
        //同步请求会阻塞操作的完成。
        NSData *retureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]];
        
        if (retureData) {
            NSLog(@"同步请求返回2");
        }

    }];
    
    [blockOperation addExecutionBlock:^{
       // NSLog(@"Start executing block3, mainThread: %@, currentThread: %@", [NSThread mainThread], [NSThread currentThread]);
        //sleep(3);
        //NSLog(@"Finish executing block3");
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"网络异步请求结束3");
            
        }];
        //同步请求会阻塞操作的完成。
//        NSData *retureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]];
//        
//        if (retureData) {
//            NSLog(@"同步请求返回3");
//        }

    }];
    
    return blockOperation;
}
@end
