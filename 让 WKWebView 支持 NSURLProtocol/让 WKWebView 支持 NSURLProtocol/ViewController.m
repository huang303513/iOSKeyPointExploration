//
//  ViewController.m
//  让 WKWebView 支持 NSURLProtocol
//
//  Created by huangchengdu on 17/3/17.
//  Copyright © 2017年 huangchengdu. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewController.h"
#import "UIWebViewController.h"
#import "MyCustomURLProtocol.h"
#import "ReplacingImageURLProtocol.h"
#import "NSURLProtocol+WKWebView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)testWKWebView:(id)sender {
    //正常情况在appdelegate或者load方法中
    [NSURLProtocol registerClass:[ReplacingImageURLProtocol class]];
    [NSURLProtocol hcd_registerScheme:@"http"];
    [NSURLProtocol hcd_registerScheme:@"https"];
    [self.navigationController pushViewController:[[WKWebViewController alloc]init] animated:YES];
    
}

- (IBAction)testUIViewView:(id)sender {
    //正常情况在appdelegate
    [NSURLProtocol registerClass:[MyCustomURLProtocol class]];
    [self.navigationController pushViewController:[[UIWebViewController alloc]init] animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    for (NSString* scheme in @[@"http", @"https"]) {
        if ([sender tag] == 0) {
           // [NSURLProtocol wk_registerScheme:scheme];
        } else {
            //[NSURLProtocol wk_unregisterScheme:scheme];
        }
    }
}



@end
