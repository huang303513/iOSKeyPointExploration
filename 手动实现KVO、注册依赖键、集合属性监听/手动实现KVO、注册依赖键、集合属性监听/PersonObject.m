//
//  PersonObject.m
//  手动实现KVO、注册依赖键、集合属性监听
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "PersonObject.h"

@implementation PersonObject

/*
 
 anObserver：观察者对象，这个对象必须实现observeValueForKeyPath:ofObject:change:context:方法，以响应属性的修改通知。
 keyPath：被监听的属性。这个值不能为nil。
 options：监听选项，这个值可以是NSKeyValueObservingOptions选项的组合。关于监听选项，我们会在下面介绍。
 context：任意的额外数据，我们可以将这些数据作为上下文数据，它会传递给观察者对象的observeValueForKeyPath:ofObject:change:context:方法。这个参数的意义在于用于区分同一对象监听同一属性(从属于同一对象)的多个不同的监听。我们将在下面看到。
 
 
 调用这个方法时，两个对象(即观察者对象及属性所属的对象)都不会被retain。
 可以多次调用这个方法，将同一个对象注册为同一属性的观察者(所有参数可以完全相同)。这时，即便在所有参数一致的情况下，新注册的观察者并不会替换原来观察者，而是会并存。这样，当属性被修改时，两次监听都会响应。


 */
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"keyPath = %@, change = %@, context = %s", keyPath, change, (char *)context);
}
@end
