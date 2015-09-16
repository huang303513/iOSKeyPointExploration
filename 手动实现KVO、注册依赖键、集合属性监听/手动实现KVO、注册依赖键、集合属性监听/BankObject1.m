//
//  BankObject1.m
//  手动实现KVO、注册依赖键、集合属性监听
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "BankObject1.h"

@implementation BankObject1

//实现手动通知的类必须重写NSObject中对automaticallyNotifiesObserversForKey:方法的实现。这个方法是在NSKeyValueObserving协议中声明的。这个方法返回一个布尔值(默认是返回YES)，以标识参数key指定的属性是否支持自动KVO。如果我们希望手动去发送通知，则针对指定的属性返回NO。

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    
    BOOL automatic = YES;
    if ([key isEqualToString:@"bankCodeEn"]) {
        automatic = NO;
    } else {
        automatic = [super automaticallyNotifiesObserversForKey:key];
    }
    
    return automatic;
}
//重写要手动实现kvo的属性的setter。

- (void)setBankCodeEn:(NSString *)bankCodeEn {
    //做这个判断以后只有在属性值真的改变以后才会激发kvo
    if (bankCodeEn != _bankCodeEn) {
        [self willChangeValueForKey:@"bankCodeEn"];
        _bankCodeEn = bankCodeEn;
        [self didChangeValueForKey:@"bankCodeEn"];
    }
}
-(void)dealloc{
    NSLog(@"2222222222222");
}
@end
