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
        if (self.isCancelled) {
            NSLog(@"Start executing %@ with data: %@, mainThread: %@, currentThread: %@", NSStringFromSelector(_cmd), self.data, [NSThread mainThread], [NSThread currentThread]);
        }
        for (NSInteger i = 0; i < 3; i++) {
            if (self.isCancelled) {
                return;
            }
            sleep(1);
            NSLog(@"Loop %@",@(i + 1));
        }
        NSLog(@"Finish executing %@", NSStringFromSelector(_cmd));
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        
    }
}
@end
