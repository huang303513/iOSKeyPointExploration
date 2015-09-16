//
//  ViewController.m
//  关于NSNotificationCenter的探讨
//
//  Created by yifan on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"
static NSString *TEST_NOTIFICATION = @"TEST_NOTIFICATION";
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)testone:(id)sender {
    /*
     notificationObserver不能为nil。
     notificationSelector回调方法有且只有一个参数(NSNotification对象)。
     如果notificationName为nil，则会接收所有的通知(如果notificationSender不为空，则接收所有来自于notificationSender的所有通知)。如代码清单1所示。
     如果notificationSender为nil，则会接收所有notificationName定义的通知；否则，接收由notificationSender发送的通知。
     监听同一条通知的多个观察者，在通知到达时，它们执行回调的顺序是不确定的，所以我们不能去假设操作的执行会按照添加观察者的顺序来执行
     */
    //这个对象为观察者、监听所有的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:nil object:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil];
}
#pragma mark 监听通知
- (void)handleNotification:(NSNotification *)notification
{
    NSLog(@"notification = %@", notification.name);
}


- (IBAction)test2:(id)sender {
    /*
     name和obj为nil时的情形与前面一个方法是相同的。
     如果queue为nil，则消息是默认在post线程中同步处理，即通知的post与转发是在同一线程中；但如果我们指定了操作队列，情况就变得有点意思了，我们一会再讲。
     block块会被通知中心拷贝一份(执行copy操作)，以在堆中维护一个block对象，直到观察者被从通知中心中移除。所以，应该特别注意在block中使用外部对象，避免出现对象的循环引用，这个我们在下面将举例说明。
     如果一个给定的通知触发了多个观察者的block操作，则这些操作会在各自的Operation Queue中被并发执行。所以我们不能去假设操作的执行会按照添加观察者的顺序来执行。
     该方法会返回一个表示观察者的对象，记得在不用时释放这个对象。
     */
    [[NSNotificationCenter defaultCenter] addObserverForName:TEST_NOTIFICATION object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        
        NSLog(@"receive thread = %@", [NSThread currentThread]);
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"post thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil];
    });

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
