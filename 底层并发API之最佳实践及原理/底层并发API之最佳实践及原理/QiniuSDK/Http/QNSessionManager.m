//
//  QNHttpManager.m
//  QiniuSDK
//
//  Created by bailong on 14/10/1.
//  Copyright (c) 2014年 Qiniu. All rights reserved.
//

//#import <AFNetworking/AFNetworking.h>
#import "AFNetworking.h"
#import "QNConfig.h"
#import "QNSessionManager.h"
#import "QNUserAgent.h"
#import "QNResponseInfo.h"
#import "QNAsyncRun.h"

#if (defined(__IPHONE_OS_VERSION_MAX_ALLOWED) && __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000) || (defined(__MAC_OS_X_VERSION_MAX_ALLOWED) && __MAC_OS_X_VERSION_MAX_ALLOWED >= 1090)

@interface QNProgessDelegate : NSObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
@property (nonatomic, strong) QNInternalProgressBlock progressBlock;
@property (nonatomic, strong) NSProgress *progress;
- (instancetype)initWithProgress:(QNInternalProgressBlock)progressBlock;
@end

@implementation QNProgessDelegate
- (instancetype)initWithProgress:(QNInternalProgressBlock)progressBlock {
	if (self = [super init]) {
		_progressBlock = progressBlock;
		_progress = nil;
	}

	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context; {
	if (context == nil || object == nil) {
		return;
	}

	NSProgress *progress = (NSProgress *)object;

	void *p = (__bridge void *)(self);
	if (p == context) {
		_progressBlock(progress.completedUnitCount, progress.totalUnitCount);
	}
	else {
		[super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
	}
}

@end

@interface QNSessionManager ()
@property (nonatomic) AFHTTPSessionManager *httpManager;
@end

static NSString *userAgent = nil;

@implementation QNSessionManager

+ (void)initialize {
	userAgent = QNUserAgent();
}

- (instancetype)initWithProxy:(NSDictionary *)proxyDict {
	if (self = [super init]) {
		NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
		if (proxyDict != nil) {
			configuration.connectionProxyDictionary = proxyDict;
		}
		_httpManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
		_httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
	}

	return self;
}

+ (QNResponseInfo *)buildResponseInfo:(NSHTTPURLResponse *)response
                            withError:(NSError *)error
                         withDuration:(double)duration
                         withResponse:(NSData *)body
                             withHost:(NSString *)host {
	QNResponseInfo *info;

	if (response) {
		int status =  (int)[response statusCode];
		NSDictionary *headers = [response allHeaderFields];
		NSString *reqId = headers[@"X-Reqid"];
		NSString *xlog = headers[@"X-Log"];
		NSString *xvia = headers[@"X-Via"];
		if (xvia == nil) {
			xvia = headers[@"X-Px"];
		}
		if (xvia == nil) {
			xvia = headers[@"Fw-Via"];
		}
		info = [[QNResponseInfo alloc] init:status withReqId:reqId withXLog:xlog withXVia:xvia withHost:host withDuration:duration withBody:body];
	}
	else {
		info = [QNResponseInfo responseInfoWithNetError:error host:host duration:duration];
	}
	return info;
}

- (void)  sendRequest:(NSMutableURLRequest *)request
    withCompleteBlock:(QNCompleteBlock)completeBlock
    withProgressBlock:(QNInternalProgressBlock)progressBlock {
	__block NSDate *startTime = [NSDate date];
	NSProgress *progress = nil;
	__block NSString *host = request.URL.host;

	if (progressBlock == nil) {
		progressBlock = ^(long long totalBytesWritten, long long totalBytesExpectedToWrite) {
		};
	}
	__block QNProgessDelegate *delegate = [[QNProgessDelegate alloc] initWithProgress:progressBlock];

	NSURLSessionUploadTask *uploadTask = [_httpManager uploadTaskWithStreamedRequest:request progress:&progress completionHandler: ^(NSURLResponse *response, id responseObject, NSError *error) {
	    NSData *data = responseObject;
	    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
	    double duration = [[NSDate date] timeIntervalSinceDate:startTime];
	    QNResponseInfo *info;
	    NSDictionary *resp = nil;
	    if (error == nil) {
	        info = [QNSessionManager buildResponseInfo:httpResponse withError:nil withDuration:duration withResponse:data withHost:host];
	        if (info.isOK) {
	            NSError *tmp;
	            resp = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&tmp];
			}
		}
	    else {
	        info = [QNSessionManager buildResponseInfo:httpResponse withError:error withDuration:duration withResponse:data withHost:host];
		}

	    if (delegate.progress != nil) {
	        [delegate.progress removeObserver:delegate forKeyPath:@"fractionCompleted" context:(__bridge void *)(delegate)];
	        delegate.progress = nil;
		}
	    completeBlock(info, resp);
	}];
	if (progress != nil) {
		[progress addObserver:delegate forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:(__bridge void *)delegate];
		delegate.progress = progress;
	}

	[request setTimeoutInterval:kQNTimeoutInterval];

	[request setValue:userAgent forHTTPHeaderField:@"User-Agent"];
	[request setValue:nil forHTTPHeaderField:@"Accept-Language"];
	[uploadTask resume];
}

- (void)multipartPost:(NSString *)url
             withData:(NSData *)data
           withParams:(NSDictionary *)params
         withFileName:(NSString *)key
         withMimeType:(NSString *)mime
    withCompleteBlock:(QNCompleteBlock)completeBlock
    withProgressBlock:(QNInternalProgressBlock)progressBlock
      withCancelBlock:(QNCancelBlock)cancelBlock {
	NSMutableURLRequest *request = [_httpManager.requestSerializer
	                                multipartFormRequestWithMethod:@"POST"
	                                                     URLString:url
	                                                    parameters:params
	                                     constructingBodyWithBlock: ^(id < AFMultipartFormData > formData) {
	    [formData appendPartWithFileData:data name:@"file" fileName:key mimeType:mime];
	}

	                                                         error:nil];
	[self sendRequest:request
	    withCompleteBlock:completeBlock
	    withProgressBlock:progressBlock];
}

- (void)         post:(NSString *)url
             withData:(NSData *)data
           withParams:(NSDictionary *)params
          withHeaders:(NSDictionary *)headers
    withCompleteBlock:(QNCompleteBlock)completeBlock
    withProgressBlock:(QNInternalProgressBlock)progressBlock
      withCancelBlock:(QNCancelBlock)cancelBlock {
	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[[NSURL alloc] initWithString:url]];
	if (headers) {
		[request setAllHTTPHeaderFields:headers];
	}

	[request setHTTPMethod:@"POST"];

	if (params) {
		[request setValuesForKeysWithDictionary:params];
	}
	[request setHTTPBody:data];
	QNAsyncRun( ^{
		[self sendRequest:request
		    withCompleteBlock:completeBlock
		    withProgressBlock:progressBlock];
	});
}

@end

#endif
