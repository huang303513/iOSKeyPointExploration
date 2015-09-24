//
//  HCDNonConcurrentOperation.m
//  OprerationQueue
//
//  Created by yifan on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDNonConcurrentOperation.h"

@interface HCDNonConcurrentOperation()
@property(nonatomic,copy)id data;
@end


@implementation HCDNonConcurrentOperation
-(instancetype)initWithData:(id)data{
    self = [super init];
    if (self) {
        self.data = data;
    }
    return self;
}

-(void)main{
    @try {
        if (self.isCancelled) return;
    
        //异步请求并不会阻塞操作的完成。。
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"网络异步请求结束");
            
        }];
        
        if (self.isCancelled) {
            return;
        }
        //同步请求会阻塞操作的完成。
//        NSData *retureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]];
//
//        if (retureData) {
//            NSLog(@"同步请求返回");
//        }

        
            //NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), self.data, [NSThread mainThread], [NSThread currentThread]);
        
//        for (NSInteger i = 0; i < 3; i++) {
//            if (self.isCancelled) {
//                return;
//            }
//            sleep(1);
//            NSLog(@"Loop %@",@(i + 1));
//        }
        NSLog(@"完成自定义非并发操作的完成 %@", NSStringFromSelector(_cmd));
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        
    }
    
}
@end
