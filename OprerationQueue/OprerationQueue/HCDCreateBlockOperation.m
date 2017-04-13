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
        NSLog(@"网络异步请求1开始--%@",[NSDate date]);
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"网络异步请求结束1--%@",[NSDate date]);
        }];
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"网络异步请求2开始---%@",[NSDate date]);
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"网络异步请求结束2---%@",[NSDate date]);
        }];
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"网络异步请求3开始");
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"网络异步请求结束3");
        }];
    }];
    

    
    return blockOperation;
}
@end
