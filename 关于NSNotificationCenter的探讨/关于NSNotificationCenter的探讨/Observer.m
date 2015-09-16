//
//  Observer.m
//  关于NSNotificationCenter的探讨
//
//  Created by yifan on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "Observer.h"
static NSString *TEST_NOTIFICATION1 = @"TEST_NOTIFICATION1";
@implementation Observer
- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        NSLog(@"Init Observer");
        /*
         
         name和obj为nil时的情形与前面一个方法是相同的。
         如果queue为nil，则消息是默认在post线程中同步处理，即通知的post与转发是在同一线程中；但如果我们指定了操作队列，情况就变得有点意思了，我们一会再讲。
         block块会被通知中心拷贝一份(执行copy操作)，以在堆中维护一个block对象，直到观察者被从通知中心中移除。所以，应该特别注意在block中使用外部对象，避免出现对象的循环引用，这个我们在下面将举例说明。
         如果一个给定的通知触发了多个观察者的block操作，则这些操作会在各自的Operation Queue中被并发执行。所以我们不能去假设操作的执行会按照添加观察者的顺序来执行。
         该方法会返回一个表示观察者的对象，记得在不用时释放这个对象。
         
         */
        __weak typeof(self) weakself = self;
        
        // 添加观察者
        _observer =  [[NSNotificationCenter defaultCenter] addObserverForName:TEST_NOTIFICATION1 object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            
            NSLog(@"handle notification");
            
            // 使用weakself不会循环引用，使用self会循环引用
            
//            __strong typeof(weakself) strongself = weakself;
//            strongself.i = 10;
            
            _i = 10;
        }];
    }
    
    return self;
}
-(void)dealloc{
    
    NSLog(@"Observer被卸载了");
}
@end
