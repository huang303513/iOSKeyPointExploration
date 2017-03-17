//
//  MyCustomURLProtocol.m
//  让 WKWebView 支持 NSURLProtocol
//
//  Created by huangchengdu on 17/3/17.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "MyCustomURLProtocol.h"

@implementation MyCustomURLProtocol
@synthesize request;
+(BOOL)canInitWithRequest:(NSURLRequest *)request{
    if ([request.URL.scheme caseInsensitiveCompare:@"myapp"] == NSOrderedSame) {
        return YES;
    }
    return NO;
}
+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    return request;
}
-(void)startLoading{
    NSURLResponse *response = [[NSURLResponse alloc]initWithURL:[self.request URL] MIMEType:@"image/png" expectedContentLength:-1 textEncodingName:nil];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"1.png" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}
-(void)stopLoading{

}
@end
