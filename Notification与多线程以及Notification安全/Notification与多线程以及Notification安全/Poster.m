//
//  Poster.m
//  Notification与多线程以及Notification安全
//
//  Created by huangchengdu on 17/5/10.
//  Copyright © 2017年 黄成都. All rights reserved.
//

#import "Poster.h"

NSString *const TEST_NOTIFICATION = @"TEST_NOTIFICATION";

@implementation Poster
- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        //在非主线发送通知
        [self performSelectorInBackground:@selector(postNotification) withObject:nil];
    }
    
    return self;
}

- (void)postNotification
{
    [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION object:nil];
}
@end
