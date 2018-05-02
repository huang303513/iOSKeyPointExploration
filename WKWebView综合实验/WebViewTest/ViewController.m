//
//  ViewController.m
//  WebViewTest
//
//  Created by huangchengdu on 2018/1/25.
//  Copyright © 2018年 huangchengdu. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (strong, nonatomic) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = true;
    self.title = @"234234234";
   
    if (true) {//实验iOS与H5的各种交互
         WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        // 设置偏好设置
        config.preferences = [[WKPreferences alloc] init];
        // 默认为0
        config.preferences.minimumFontSize = 10;
        // 默认认为YES
        config.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        config.processPool = [[WKProcessPool alloc] init];
        config.userContentController = [[WKUserContentController alloc] init];
        //注意在这里注入JS对象名称 "JSObjec"
        [config.userContentController addScriptMessageHandler:self name:@"JSObjec"];
        
        //从OC中获取到一些数据后存入JS
        NSString *sendToken = [NSString stringWithFormat:@"localStorage.setItem(\"accessToken\",'%@');",@"黄成都"];
        //WKUserScriptInjectionTimeAtDocumentStart JS加载前执行
        //WKUserScriptInjectionTimeAtDocumentEnd JS加载后执行
        //injectionTime配置不要写错  forMainFrameOnly  NO(全局窗口) YES(只限主窗口)
        WKUserScript *sendTokenScript = [[WKUserScript alloc]initWithSource:sendToken injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        //注入JS
        [config.userContentController addUserScript:sendTokenScript];
        
        self.webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        self.webView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        self.webView.backgroundColor = [UIColor greenColor];
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
        [self.view addSubview:self.webView];
        NSURL *path = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
        [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
    } else {//支付宝支付实验
        self.webView = [[WKWebView alloc]init];
        self.webView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64);
        self.webView.backgroundColor = [UIColor greenColor];
        self.webView.navigationDelegate = self;
        self.webView.UIDelegate = self;
        [self.view addSubview:self.webView];
        int dd = arc4random();
        NSString *url = [NSString stringWithFormat:@"%@%d",@"https://pages.ctrip.com/ztrip/market/zhongxiexingtest/#/index?time=",dd];
        NSLog(@"%@",url);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:60];
        [self.webView loadRequest:request];;
        
    }
}

//https://www.jianshu.com/p/3b958272bb2f
//http://blog.csdn.net/tencent_bugly/article/details/54668721
//https://www.jianshu.com/p/253e76a74b38
//https://www.jianshu.com/p/8d416628e3fe
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *url = navigationAction.request.URL.absoluteString;
    
    if ([url containsString:@"alipay://"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:^(BOOL success) {
        }];
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }else{
         decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    typeof(self) weakSdelf = self;
    //通过document的title设置当前title
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id  _Nonnull result, NSError * _Nonnull error) {
        weakSdelf.title = result;
        
    }];
    
}

-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    [webView evaluateJavaScript:@"let obj = {name:'huang',age:123};console.log(obj)" completionHandler:^(id _Nullable xx, NSError * _Nullable error) {
        
    }];
    
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation{
}

//====================WKScriptMessageHandler代理方法======================
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"%@",message.body);//message.body这里面内容是js里传过来的参数
    //message.name这个是注入的JS对象名称 "JSObjec"
    if ([message.name isEqualToString:@"JSObjec"]) {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        // 此处填写相应的逻辑代码
        NSLog(message.body);
    }
}



@end
