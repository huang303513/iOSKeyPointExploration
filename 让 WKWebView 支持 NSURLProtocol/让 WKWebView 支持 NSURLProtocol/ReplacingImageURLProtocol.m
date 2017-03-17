//
//  ReplacingImageURLProtocol.m
//  让 WKWebView 支持 NSURLProtocol
//
//  Created by huangchengdu on 17/3/17.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "ReplacingImageURLProtocol.h"
#import <UIKit/UIKit.h>

static NSString* const FilteredKey = @"FilteredKey";

@implementation ReplacingImageURLProtocol

+(BOOL)canInitWithRequest:(NSURLRequest *)request{
    NSString* extension = request.URL.pathExtension;
    BOOL isImage = [@[@"png", @"jpeg", @"gif", @"jpg"] indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [extension compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
    }] != NSNotFound;
    //没有处理过并且是图片。则返回true，否则返回false表示不处理。
    if (isImage) {
        //NSLog(@"sdfsdfs");
    }
    BOOL result = [NSURLProtocol propertyForKey:FilteredKey inRequest:request] == nil && isImage;
    return result;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSMutableURLRequest* request = self.request.mutableCopy;
    //表示这个请求已经处理过。否则死循环
    [NSURLProtocol setProperty:@YES forKey:FilteredKey inRequest:request];
    
    NSData* data = UIImagePNGRepresentation([UIImage imageNamed:@"1"]);
    NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"image/png" expectedContentLength:data.length textEncodingName:nil];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

//这个方法必须重写
- (void)stopLoading {
    
}

@end
