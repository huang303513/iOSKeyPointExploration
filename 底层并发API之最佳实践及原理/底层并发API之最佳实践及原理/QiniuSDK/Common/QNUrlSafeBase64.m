//
//  QiniuSDK
//
//  Created by bailong on 14-9-28.
//  Copyright (c) 2014年 Qiniu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QNUrlSafeBase64.h"

static uint8_t const kBase64EncodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";

@implementation QNUrlSafeBase64

+ (NSString *)encodeString:(NSString *)sourceString {
	NSData *data = [NSData dataWithBytes:[sourceString UTF8String] length:[sourceString lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
	return [self encodeData:data];
}

+ (NSString *)encodeData:(NSData *)data {
	NSUInteger length = [data length];
	NSMutableData *mutableData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];

	uint8_t *input = (uint8_t *)[data bytes];
	uint8_t *output = (uint8_t *)[mutableData mutableBytes];

	for (NSUInteger i = 0; i < length; i += 3) {
		NSUInteger value = 0;

		for (NSUInteger j = i; j < (i + 3); j++) {
			value <<= 8;

			if (j < length) {
				value |= (0xFF & input[j]);
			}
		}



		NSUInteger idx = (i / 3) * 4;
		output[idx + 0] = kBase64EncodingTable[(value >> 18) & 0x3F];
		output[idx + 1] = kBase64EncodingTable[(value >> 12) & 0x3F];
		output[idx + 2] = (i + 1) < length ? kBase64EncodingTable[(value >> 6) & 0x3F] : '=';
		output[idx + 3] = (i + 2) < length ? kBase64EncodingTable[(value >> 0) & 0x3F] : '=';
	}

	return [[NSString alloc] initWithData:mutableData encoding:NSASCIIStringEncoding];
}

@end
