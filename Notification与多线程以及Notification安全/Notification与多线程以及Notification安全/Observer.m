//
//  Observer.m
//  Notification与多线程以及Notification安全
//
//  Created by huangchengdu on 17/5/10.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import "Observer.h"
#import "Poster.h"



@implementation Observer
- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        

        //初始化一个Poster对象就会自动在非主线发送一个通知
        _poster = [[Poster alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:TEST_NOTIFICATION object:nil];
        
    }
    
    return self;
}


/**
 这个方法执行过程中，如果Observer对象被释放，则会奔溃

 @param notification 通知对象
 */
- (void)handleNotification:(NSNotification *)notification
{
    NSLog(@"handle notification begin");
    sleep(4);
    NSLog(@"handle notification end");
    //2017.5月份已经不奔溃了，貌似苹果改变了底层实现
    self.i = 10;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    NSLog(@"Observer dealloc");
}
@end
