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

//非并发的Operation如果有start方法，则不会调用main方法
-(void)main{
    @try {
        if (self.isCancelled) return;
        
        [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://7xidnq.com1.z0.glb.clouddn.com/2015-09-24_16:52:41_3WvCCI5l.jpg"]]  returningResponse:nil error:nil];
        
        if (self.isCancelled) {
            return;
        }
        NSLog(@"完成自定义非并发操作的完成 %@", NSStringFromSelector(_cmd));
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@", exception);
    }
    @finally {
        
    }
    
}




@end
