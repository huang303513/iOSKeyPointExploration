//
//  Observer.h
//  关于NSNotificationCenter的探讨
//
//  Created by yifan on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Observer : NSObject
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, weak) id<NSObject> observer;
@end
