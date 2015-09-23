//
//  QNConfig.h
//  QiniuSDK
//
//  Created by bailong on 14-9-29.
//  Copyright (c) 2014年 Qiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *    默认上传服务器
 */
extern NSString *const kQNUpHost;

/**
 *    备用上传服务器，当默认服务器网络连接失败时使用
 */
extern NSString *const kQNUpHostBackup;

/**
 *    断点上传时的分片大小
 */
extern const UInt32 kQNChunkSize;

/**
 *    断点上传时的分块大小
 */
extern const UInt32 kQNBlockSize;

/**
 *    上传失败的重试次数
 */
extern const UInt32 kQNRetryMax;

/**
 *    如果大于此值就使用断点上传，否则使用form上传
 */
extern const UInt32 kQNPutThreshold;

/**
 *    超时时间
 */
extern const float kQNTimeoutInterval;
