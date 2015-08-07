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
    sleep(3);
    NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));

}

- (void)myTaskMethod2:(id)data{
    NSLog(@"Start executing %@ with dataString: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding], [NSThread mainThread], [NSThread currentThread]);
    sleep(3);
    NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
    
}
@end
