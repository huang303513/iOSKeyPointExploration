//
//  HCDConcurrentOperation.h
//  OprerationQueue
//
//  Created by yifan on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  如果你希望拥有更多的控制权，或者想在一个操作中可以执行异步任务，那么就重写 start方法, 但是注意：这种情况下，你必须手动管理操作的状态， 只有当发送 isFinished的 KVO 消息时，才认为是 operation 结束。
 */
/**
 *  当实现了start方法时，默认会执行start方法，而不执行main方法。为了让操作队列能够捕获到操作的改变，需要将状态的属性以配合 KVO的方式进行实现。如果你不使用它们默认的 setter 来进行设置的话你就需要在合适的时候发送合适的 KVO消息。
 
 需要手动管理的状态有：
 
 isExecuting
 代表任务正在执行中
 isFinished
 代表任务已经执行完成
 isCancelled
 代表任务已经取消执行
 */
@interface HCDConcurrentOperation : NSOperation

@end
