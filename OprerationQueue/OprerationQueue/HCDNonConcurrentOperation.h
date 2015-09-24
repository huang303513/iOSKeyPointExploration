//
//  HCDNonConcurrentOperation.h
//  OprerationQueue
//
//  Created by yifan on 15/8/8.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

/**
 你可以使用系统提供的一些现成的NSOperation的子类， 如 NSBlockOperation、NSInvocationOperation等（如上例子）。你也可以实现自己的子类， 通过重写 main 或者start方法 来定义自己的 operations 。
 使用 main方法非常简单，开发者不需要管理一些状态属性（例如 isExecuting 和 isFinished），当 main 方法返回的时候，这个 operation 就结束了。这种方式使用起来非常简单，但是灵活性相对重写 start 来说要少一些， 因为main方法执行完就认为operation结束了，所以一般可以用来执行同步任务。
 
 - returns: 
 */
#import <Foundation/Foundation.h>
/**
 一个自定义操作至少实现两个方法：一个自定义的初始化方法  main方法。
 
 - returns: <#return value description#>
 */
@interface HCDNonConcurrentOperation : NSOperation

- (instancetype)initWithData:(id)data;
@end
