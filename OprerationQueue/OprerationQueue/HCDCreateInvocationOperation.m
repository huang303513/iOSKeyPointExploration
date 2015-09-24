//
//  HCDCreateInvocationOperation.m
//  OprerationQueue
//
//  Created by 黄成都 on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDCreateInvocationOperation.h"

@implementation HCDCreateInvocationOperation
- (NSInvocationOperation *)invocationOperationWithData:(id)data{
    return [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(myTaskMethod1:) object:data];
}

-(NSInvocationOperation *)invocationOperationWithData:(id)data userInput:(NSString *)userInPut{
    NSInvocationOperation *operation = nil;
    if ((!userInPut) || (userInPut.length == 0)) {
        operation = [self invocationOperationWithData:data];
    }else{
        SEL selecter = NSSelectorFromString([NSString stringWithFormat:@"%@:",userInPut]);
        operation = [[NSInvocationOperation alloc]initWithTarget:self selector:selecter object:data];
    }
    return operation;
}



- (void)myTaskMethod1:(id)data{
    NSLog(@"Start executing %@ with dataString: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding], [NSThread mainThread], [NSThread currentThread]);
    //异步请求并不会阻塞操作的完成。。
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]] queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"网络异步请求结束");
        
    }];
    //同步请求会阻塞操作的完成。
    NSData *retureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]];
    
    if (retureData) {
        NSLog(@"同步请求返回");
    }
    NSLog(@"完成执行方法1 %@", NSStringFromSelector(_cmd));

}

- (void)myTaskMethod2:(id)data{
    
    
    
   // NSLog(@"Start executing %@ with dataString: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding], [NSThread mainThread], [NSThread currentThread]);
    //sleep(3);
    NSLog(@"完成执行方法二 %@", NSStringFromSelector(_cmd));
    
}
@end
