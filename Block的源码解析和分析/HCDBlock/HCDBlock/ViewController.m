//
//  ViewController.m
//  HCDBlock
//
//  Created by maiyun on 15/6/12.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ViewController.h"

typedef int(^blk_t)(int);

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // -----------Block自动变量截取--------------
//    int dmy = 256;
//    int val = 10;
//    const char *fmt = "val = %d\n";
//    void (^blk)(void) = ^void (void){printf(fmt,val);};
//    val = 2;
//    fmt = "These values were changed. val = %d\n";
//    blk();
    
    //=============Block截获的变量其实是截获变量的实例指针。
    id array = [NSMutableArray array];
    void (^blk)(void) = ^{
        id obj = @"123";
        [array addObject:obj];
        //出错
        //array = [NSMutableArray array];
    };
    NSLog(@"%@",array);
    blk();
    NSLog(@"%@",array);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
