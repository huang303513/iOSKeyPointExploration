//
//  QNResumeUpload.h
//  QiniuSDK
//
//  Created by bailong on 14/10/1.
//  Copyright (c) 2014年 Qiniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNUploadManager.h"
#import "QNhttpDelegate.h"

@class QNHttpManager;
@interface QNResumeUpload : NSObject

- (instancetype)initWithData:(NSData *)data
                    withSize:(UInt32)size
                     withKey:(NSString *)key
                   withToken:(NSString *)token
       withCompletionHandler:(QNUpCompletionHandler)block
                  withOption:(QNUploadOption *)option
              withModifyTime:(NSDate *)time
                withRecorder:(id <QNRecorderDelegate> )recorder
             withRecorderKey:(NSString *)recorderKey
             withHttpManager:(id <QNHttpDelegate> )http;

- (void)run;

@end
