//
//  NSURLAdditions.m
//  letao
//
//  Created by wangchen on 11-7-25.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSURLAdditions.h"


@implementation NSURL (Additions)

+ (BOOL)isWebURL:(NSURL*)URL {
	if(!URL.scheme)
	{
		return NO;
	}
	else {
	return [URL.scheme caseInsensitiveCompare:@"http"] == NSOrderedSame
	|| [URL.scheme caseInsensitiveCompare:@"https"] == NSOrderedSame
	|| [URL.scheme caseInsensitiveCompare:@"ftp"] == NSOrderedSame
	|| [URL.scheme caseInsensitiveCompare:@"ftps"] == NSOrderedSame
	|| [URL.scheme caseInsensitiveCompare:@"data"] == NSOrderedSame
	|| [URL.scheme caseInsensitiveCompare:@"file"] == NSOrderedSame;
	}
}

@end
