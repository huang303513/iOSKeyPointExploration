//
//  HCDImageManager.m
//  Cell异步图片加载优化、缓存机制详解
//
//  Created by yifan on 15/9/22.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HCDImageManager.h"

@implementation HCDImageManager

+(instancetype)sharedManager{
    static HCDImageManager *manager  = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HCDImageManager alloc]init];
    });
    return manager;
}

- (NSOperationQueue *)queue
{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}

- (NSMutableDictionary *)operations
{
    if (nil == _operations) {
        
        _operations = [NSMutableDictionary dictionary];
    }
    return _operations;
}

- (NSMutableDictionary *)images
{
    if (nil == _images) {
        _images = [NSMutableDictionary dictionary];
    }
    
    return _images;
}



@end
