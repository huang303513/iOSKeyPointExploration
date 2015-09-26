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

- (NSCache *)images
{
    if (nil == _images) {
        _images = [NSCache new];
        _images.countLimit = 100;
        _images.totalCostLimit = 50 * 1024 *1024;
    }
    return _images;
}



@end
