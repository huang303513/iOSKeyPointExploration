//
//  ViewController.m
//  Category添加属性的三种实现
//
//  Created by 黄成都 on 16/3/12.
//  Copyright © 2016年 黄成都. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Associate.h"
#import "NSObject+Associate1.h"
#import "NSObject+Associate2.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *nameObject = [NSObject new];
    nameObject.name = @"黄成都";
    NSLog(@"第一种：%@",nameObject.name);
    
    NSObject *addressObject = [NSObject new];
    addressObject.address = @"上海";
    NSLog(@"第二种：%@",addressObject.address);
    
    NSObject *phoneObject = [NSObject new];
    phoneObject.phone = @"123456778";
    NSLog(@"第三种：%@",phoneObject.phone);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
