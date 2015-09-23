//
//  QNResponseInfo.m
//  QiniuSDK
//
//  Created by bailong on 14/10/2.
//  Copyright (c) 2014年 Qiniu. All rights reserved.
//


#import "QNResponseInfo.h"

const int kQNFileError = -4;
const int kQNInvalidArgument = -3;
const int kQNRequestCancelled = -2;
const int kQNNetworkError = -1;

static QNResponseInfo *cancelledInfo = nil;

static NSString *domain = @"qiniu.com";

@implementation QNResponseInfo

+ (instancetype)cancel {
	return [[QNResponseInfo alloc] initWithCancelled];
}

+ (instancetype)responseInfoWithInvalidArgument:(NSString *)text {
	return [[QNResponseInfo alloc] initWithStatus:kQNInvalidArgument errorDescription:text];
}

+ (instancetype)responseInfoWithNetError:(NSError *)error host:(NSString *)host duration:(double)duration {
	if (error.code != -1003) {
	}
	return [[QNResponseInfo alloc] initWithStatus:kQNNetworkError error:error host:host duration:duration];
}

+ (instancetype)responseInfoWithFileError:(NSError *)error {
	return [[QNResponseInfo alloc] initWithStatus:kQNFileError error:error];
}

- (instancetype)initWithCancelled {
	return [self initWithStatus:kQNRequestCancelled errorDescription:@"cancelled by user"];
}

- (instancetype)initWithStatus:(int)status
                         error:(NSError *)error {
	return [self initWithStatus:status error:error host:nil duration:0];
}

- (instancetype)initWithStatus:(int)status
                         error:(NSError *)error
                          host:(NSString *)host
                      duration:(double)duration {
	if (self = [super init]) {
		_statusCode = status;
		_error = error;
		_host = host;
		_duration = duration;
	}
	return self;
}

- (instancetype)initWithStatus:(int)status
              errorDescription:(NSString *)text {
	NSError *error = [[NSError alloc] initWithDomain:domain code:status userInfo:@{ @"error":text }];
	return [self initWithStatus:status error:error];
}

- (instancetype)init:(int)status
           withReqId:(NSString *)reqId
            withXLog:(NSString *)xlog
            withXVia:(NSString *)xvia
            withHost:(NSString *)host
        withDuration:(double)duration
            withBody:(NSData *)body {
	if (self = [super init]) {
		_statusCode = status;
		_reqId = [reqId copy];
		_xlog = [xlog copy];
		_xvia = [xvia copy];
		_host = [host copy];
		_duration = duration;
		if (status != 200) {
			if (body == nil) {
				_error = [[NSError alloc] initWithDomain:domain code:_statusCode userInfo:nil];
			}
			else {
				NSError *tmp;
				NSDictionary *uInfo = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:&tmp];
				if (tmp != nil) {
					// 出现错误时，如果信息是非UTF8编码会失败，返回nil
					NSString *str = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
					if (str == nil) {
						str = @"";
					}
					uInfo = @{ @"error": str };
				}
				_error = [[NSError alloc] initWithDomain:domain code:_statusCode userInfo:uInfo];
			}
		}
		else if (body == nil || body.length == 0) {
			NSDictionary *uInfo = @{ @"error":@"no response json" };
			_error = [[NSError alloc] initWithDomain:domain code:_statusCode userInfo:uInfo];
		}
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p, status: %d, requestId: %@, xlog: %@, xvia: %@, host: %@ duration:%f s error: %@>", NSStringFromClass([self class]), self, _statusCode, _reqId, _xlog, _xvia, _host, _duration, _error];
}

- (BOOL)isCancelled {
	return _statusCode == kQNRequestCancelled;
}

- (BOOL)isOK {
	return _statusCode == 200 && _error == nil && _reqId != nil;
}

- (BOOL)isConnectionBroken {
	// reqId is nill means the server is not qiniu
	return _statusCode == kQNNetworkError;
}

- (BOOL)needSwitchServer {
	return _statusCode == kQNNetworkError || (_statusCode / 100 == 5 && _statusCode != 579);
}

- (BOOL)couldRetry {
	return (_statusCode >= 500 && _statusCode < 600 && _statusCode != 579) || _statusCode == kQNNetworkError || _statusCode == 996 || _statusCode == 406 || (_statusCode == 200 && _error != nil);
}

@end
