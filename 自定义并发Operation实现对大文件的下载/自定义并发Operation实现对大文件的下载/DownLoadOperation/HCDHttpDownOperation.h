//
//  HCDHttpDownOperation.h
//  自定义并发Operation实现对大文件的下载
//
//  Created by 黄成都 on 15/12/5.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HCDHttpDownOperation;

@protocol HCDHttpDownLoadDelegate <NSObject>
@optional

-(void)HCDHttpDownLoader:(HCDHttpDownOperation *)downLoader downLoadProgress:(double)progress;
-(void)HCDHttpDownLoader:(HCDHttpDownOperation *)downLoader didFinishWithData:(NSData *)data;
-(void)HCDHttpDownLoader:(HCDHttpDownOperation *)downLoader didFailWithError:(NSError *)error;
@end


@interface HCDHttpDownOperation : NSOperation

-(id)initWithRequestURL:(NSURL *)url delegate:(id<HCDHttpDownLoadDelegate>)delegate;
-(id)initWithRequestURL:(NSURL *)url progress:(void(^)(float percent))progress completion:(void (^)(id response, NSError *error))completion;

@end
