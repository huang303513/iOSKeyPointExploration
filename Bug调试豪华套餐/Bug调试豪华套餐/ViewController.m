//
//  ViewController.m
//  Bug调试豪华套餐
//
//  Created by huangchengdu on 15/11/23.
//  Copyright © 2015年 huangchengdu. All rights reserved.
//


#define NSLog(format, ...) do { \
fprintf(stderr, "<%s : %d> %s\n", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, __func__); \
(NSLog)((format), ##__VA_ARGS__); \
fprintf(stderr, "------------------------------------------------\n"); \
} while (0)

#import "ViewController.h"
#import "TestSymbolicBreak.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1
    //添加全局断点
    
    //2
    //条件断点.只有i==849的时候。才会触发断点
    //编辑断点的Action。。可以通过筛选条件设置bug.设置需要显示的东西。或者设置一个提示音
//    for (int i = 0; i <= 1000; i++) {
//        NSLog(@"%d",i);
//    }
    
    //3
    //设置Symbolic断点。比如想知道所有调用了doesNotRecognizeSelector方法的地方都激发断点
    //[((id)[[TestSymbolicBreak alloc]init]) testSymbol];
    
    
    //4
    //使用强化的NSLog
    NSLog(@"%@",NSStringFromClass([self class]));
    
    //5
    //使用Zombie对象调试
    
    
    //===========================调试进阶lldb命令================================
    NSString *test1 = @"hjjk";
    /*
     (lldb) print test1
     (__NSCFConstantString *) $0 = 0x0000000109f7f0a0 @""
     (lldb) print test1
     (__NSCFConstantString *) $1 = 0x0000000109f7f0a0 @""
     */
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
