//
//  QNUploader.h
//  QiniuSDK
//
//  Created by bailong on 14-9-28.
//  Copyright (c) 2014年 Qiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __IPHONE_OS_VERSION_MIN_REQUIRED
#import <MobileCoreServices/MobileCoreServices.h>
#import <UIKit/UIKit.h>
#else
#import <CoreServices/CoreServices.h>
#endif

#import "QNConfig.h"
#import "QNHttpManager.h"
#import "QNSessionManager.h"
#import "QNResponseInfo.h"
#import "QNCrc32.h"
#import "QNUploadManager.h"
#import "QNResumeUpload.h"
#import "QNFormUpload.h"
#import "QNUploadOption+Private.h"
#import "QNAsyncRun.h"

@interface QNUploadManager ()
@property (nonatomic) id <QNHttpDelegate> httpManager;
@property (nonatomic) id <QNRecorderDelegate> recorder;
@property (nonatomic, strong) QNRecorderKeyGenerator recorderKeyGen;
@end

@implementation QNUploadManager

- (instancetype)init {
	return [self initWithRecorder:nil recorderKeyGenerator:nil];
}

- (instancetype)initWithRecorder:(id <QNRecorderDelegate> )recorder {
	return [self initWithRecorder:recorder recorderKeyGenerator:nil];
}

- (instancetype)initWithRecorder:(id <QNRecorderDelegate> )recorder
            recorderKeyGenerator:(QNRecorderKeyGenerator)recorderKeyGenerator {
	return [self initWithRecorder:recorder recorderKeyGenerator:recorderKeyGenerator proxy:nil];
}

- (instancetype)initWithRecorder:(id <QNRecorderDelegate> )recorder
            recorderKeyGenerator:(QNRecorderKeyGenerator)recorderKeyGenerator
                           proxy:(NSDictionary *)proxyDict {
	if (self = [super init]) {
#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)
		BOOL lowVersion = NO;
	#if defined(__IPHONE_OS_VERSION_MAX_ALLOWED)
		float sysVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
		if (sysVersion < 7.0) {
			lowVersion = YES;
		}
	#else
		NSOperatingSystemVersion sysVersion = [[NSProcessInfo processInfo] operatingSystemVersion];

		if ((sysVersion.majorVersion = 10 && sysVersion.minorVersion < 9)) {
			lowVersion = YES;
		}
	#endif
		if (lowVersion) {
			_httpManager = [[QNHttpManager alloc] init];
		}
		else {
			_httpManager = [[QNSessionManager alloc] initWithProxy:proxyDict];
		}
#else
		_httpManager = [[QNHttpManager alloc] init];
#endif
		_recorder = recorder;
		_recorderKeyGen = recorderKeyGenerator;
	}
	return self;
}

+ (instancetype)sharedInstanceWithRecorder:(id <QNRecorderDelegate> )recorder
                      recorderKeyGenerator:(QNRecorderKeyGenerator)recorderKeyGenerator {
	static QNUploadManager *sharedInstance = nil;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[self alloc] initWithRecorder:recorder recorderKeyGenerator:recorderKeyGenerator];
	});

	return sharedInstance;
}

+ (BOOL)checkAndNotifyError:(NSString *)key
                      token:(NSString *)token
                       data:(NSData *)data
                       file:(NSString *)file
                   complete:(QNUpCompletionHandler)completionHandler {
	NSString *desc = nil;
	if (completionHandler == nil) {
		@throw [NSException exceptionWithName:NSInvalidArgumentException
		                               reason:@"no completionHandler" userInfo:nil];
		return YES;
	}
	if (data == nil && file == nil) {
		desc = @"no input data";
	}
	else if (token == nil || [token isEqualToString:@""]) {
		desc = @"no token";
	}
	if (desc != nil) {
		QNAsyncRun( ^{
			completionHandler([QNResponseInfo responseInfoWithInvalidArgument:desc], key, nil);
		});
		return YES;
	}
	return NO;
}

- (void)putData:(NSData *)data
            key:(NSString *)key
          token:(NSString *)token
       complete:(QNUpCompletionHandler)completionHandler
         option:(QNUploadOption *)option {
	if ([QNUploadManager checkAndNotifyError:key token:token data:data file:nil complete:completionHandler]) {
		return;
	}
	QNFormUpload *up = [[QNFormUpload alloc]
	                    initWithData:data
	                            withKey:key
	                          withToken:token
	              withCompletionHandler:completionHandler
	                         withOption:option
	                    withHttpManager:_httpManager];
	QNAsyncRun( ^{
		[up put];
	});
}

- (void)putFile:(NSString *)filePath
            key:(NSString *)key
          token:(NSString *)token
       complete:(QNUpCompletionHandler)completionHandler
         option:(QNUploadOption *)option {
	if ([QNUploadManager checkAndNotifyError:key token:token data:nil file:filePath complete:completionHandler]) {
		return;
	}

	@autoreleasepool {
		NSError *error = nil;
		NSDictionary *fileAttr = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&error];

		if (error) {
			QNAsyncRun( ^{
				QNResponseInfo *info = [QNResponseInfo responseInfoWithFileError:error];
				completionHandler(info, key, nil);
			});
			return;
		}

		NSNumber *fileSizeNumber = fileAttr[NSFileSize];
		UInt32 fileSize = [fileSizeNumber intValue];
		NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
		if (error) {
			QNAsyncRun( ^{
				QNResponseInfo *info = [QNResponseInfo responseInfoWithFileError:error];
				completionHandler(info, key, nil);
			});
			return;
		}
		if (fileSize <= kQNPutThreshold) {
			[self putData:data key:key token:token complete:completionHandler option:option];
			return;
		}

		QNUpCompletionHandler complete = ^(QNResponseInfo *info, NSString *key, NSDictionary *resp)
		{
			completionHandler(info, key, resp);
		};

		NSDate *modifyTime = fileAttr[NSFileModificationDate];
		NSString *recorderKey = key;
		if (_recorder != nil && _recorderKeyGen != nil) {
			recorderKey = _recorderKeyGen(key, filePath);
		}

		QNResumeUpload *up = [[QNResumeUpload alloc]
		                      initWithData:data
		                             withSize:fileSize
		                              withKey:key
		                            withToken:token
		                withCompletionHandler:complete
		                           withOption:option
		                       withModifyTime:modifyTime
		                         withRecorder:_recorder
		                      withRecorderKey:recorderKey
		                      withHttpManager:_httpManager];
		QNAsyncRun( ^{
			[up run];
		});
	}
}

@end
