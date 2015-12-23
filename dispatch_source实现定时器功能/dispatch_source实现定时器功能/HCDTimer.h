//
//  HCDTimer.h
//  dispatch_source实现定时器功能
//
//  Created by huangchengdu on 15/12/23.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDTimer : NSObject
//定时器初始化方法 第一个参数是时间间隔 第二个参数是执行的block回调。
+ (HCDTimer *)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds block:(dispatch_block_t)block;

//手动触发一次定时器操作
- (void)fire;
//停止一个定时器，但是定时器并没有被卸载，需要调用下面那个方法卸载
-(void)stopTimer;

//停止定时器，停止以后，这个定时器就自动停止
- (void)invalidate;
@end
