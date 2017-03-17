//
//  NSURLProtocol+WKWebView.m
//  让 WKWebView 支持 NSURLProtocol
//
//  Created by huangchengdu on 17/3/17.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "NSURLProtocol+WKWebView.h"
#import <WebKit/WebKit.h>
FOUNDATION_STATIC_INLINE Class ContextControllerClass(){
    static Class cls;
    if (!cls) {
        cls = [[[WKWebView new] valueForKey:@"browsingContextController"] class];
    }
    return cls;
}
FOUNDATION_STATIC_INLINE SEL RegisterSchemeSelector(){
    return NSSelectorFromString(@"registerSchemeForCustomProtocol:");
}
FOUNDATION_STATIC_INLINE SEL UnregisterSchemeSelector() {
    return NSSelectorFromString(@"unregisterSchemeForCustomProtocol:");
}


@implementation NSURLProtocol (WKWebView)
+(void)hcd_registerScheme:(NSString *)scheme{
    Class cls = ContextControllerClass();
    SEL sel = RegisterSchemeSelector();
    if ([(id)cls respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [(id)cls performSelector:sel withObject:scheme];
#pragma clang diagnostic pop
    }
}

+(void)hcd_unregisterScheme:(NSString *)scheme{
    Class cls = ContextControllerClass();
    SEL sel = UnregisterSchemeSelector();
    if ([(id)cls respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [(id)cls performSelector:sel withObject:scheme];
#pragma clang diagnostic pop
    }
}
@end
