//
//  SecondViewController.m
//  关于NSNotificationCenter的探讨
//
//  Created by yifan on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "SecondViewController.h"
#import "Observer.h"

static NSString *TEST_NOTIFICATION1 = @"TEST_NOTIFICATION1";
@interface SecondViewController ()

@end

@implementation SecondViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self createObserver];
     [[NSNotificationCenter defaultCenter] postNotificationName:TEST_NOTIFICATION1 object:nil];
}
- (void)createObserver {
    //这个对象犹豫被通知中心引用了，所以他没有被卸载
    Observer *observer = [[Observer alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
