//
//  ViewController.m
//  JavaScriptCoreDemo
//
//  Created by huangchengdu on 16/3/24.
//  Copyright © 2016年 huangchengdu. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Person.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JSContext *context = [[JSContext alloc]init];
    [context evaluateScript:@"var num = 5 + 5"];
    [context evaluateScript:@"var names = ['Grace', 'Ada', 'Margaret']"];
    [context evaluateScript:@"var triple = function(value){return value * 3}"];
    JSValue *tripleNum = [context evaluateScript:@"triple(num)"];
    NSLog(@"Tripled: %d",[tripleNum toInt32]);
    //下标值
    JSValue *names = context[@"names"];
    JSValue *initialName = names[0];
    NSLog(@"The first name: %@",[initialName toString]);
    //调用方法
    JSValue *tripleFunction = context[@"triple"];
    JSValue *result = [tripleFunction callWithArguments:@[@5]];
    NSLog(@"Five tripled: %d",[result toInt32]);
    //错误处理
    context.exceptionHandler = ^(JSContext *context , JSValue *exception){
        NSLog(@"JS Error: %@",exception);
    };
    [context evaluateScript:@"function multiply(value1, value2) { return value1 * value2 "];
    
    //================JavaScript调用==================
    //让 JSContext 访问我们的本地客户端代码的方式主要有两种：block 和 JSExport 协议。
    //Block调用
    context[@"simplifyString"] = ^(NSString *input){
        NSMutableString *mutableString = [input mutableCopy];
        [mutableString appendString:@",黄成都"];
        return mutableString;
    };
    NSLog(@"%@", [context evaluateScript:@"simplifyString('天下第一帅')"]);
    
    
    //JSExport调用
//    NSString *mustacheJSString = [NSString stringWithContentsOfFile:@"mustache.js" encoding:NSUTF8StringEncoding error:nil];
//    [context evaluateScript:mustacheJSString];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
