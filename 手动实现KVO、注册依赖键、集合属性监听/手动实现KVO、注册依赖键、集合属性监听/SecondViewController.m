//
//  SecondViewController.m
//  手动实现KVO、注册依赖键、集合属性监听
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "SecondViewController.h"
#import "PersonObject.h"
#import "BankObject1.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PersonObject    *personInstance = [[PersonObject alloc] init];
    BankObject1      *bankInstance = [[BankObject1 alloc] init];
    //观察手动实现kvo的属性
    [bankInstance addObserver:personInstance forKeyPath:@"bankCodeEn" options:NSKeyValueObservingOptionNew context:@"123"];
    
    NSString *bankCodeEn = @"CCB";
    bankInstance.bankCodeEn = bankCodeEn;
    bankInstance.bankCodeEn = bankCodeEn;
    //手动实现的kvo不需要手动移除
}

-(void)dealloc{
    NSLog(@"11111111");
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
