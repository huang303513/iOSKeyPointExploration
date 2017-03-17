//
//  UIWebViewController.m
//  让 WKWebView 支持 NSURLProtocol
//
//  Created by huangchengdu on 17/3/17.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "UIWebViewController.h"
#import "MyCustomURLProtocol.h"

@interface UIWebViewController ()
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.webView];
    
    NSString *localHtmlFilePath = [[NSBundle mainBundle] pathForResource:@"file.html" ofType:nil];
    NSString *html = [NSString stringWithContentsOfFile:localHtmlFilePath encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:html baseURL:nil];
    
}

@end
