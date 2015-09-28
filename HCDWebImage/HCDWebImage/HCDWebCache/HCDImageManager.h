//
//  HCDImageManager.h
//  Cell异步图片加载优化、缓存机制详解
//
//  Created by yifan on 15/9/22.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HCDImageManager : NSObject
/**
 *  存放所有下载操作的队列
 */
@property (nonatomic,strong) NSOperationQueue* queue;

/**
 *  存放所有的下载操作（url是key，operation对象是value）
 */
@property (nonatomic,strong) NSMutableDictionary* operations;
/**
 *  存放所有下载完成的图片，用于缓存
 */
@property (nonatomic,strong) NSCache* images;



+(instancetype)sharedManager;
@end
