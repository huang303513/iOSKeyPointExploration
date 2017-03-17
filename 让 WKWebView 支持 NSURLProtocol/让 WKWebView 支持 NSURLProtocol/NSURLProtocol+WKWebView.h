//
//  NSURLProtocol+WKWebView.h
//  让 WKWebView 支持 NSURLProtocol
//
//  Created by huangchengdu on 17/3/17.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLProtocol (WKWebView)
+(void)hcd_registerScheme:(NSString *)scheme;
+(void)hcd_unregisterScheme:(NSString *)scheme;
@end
