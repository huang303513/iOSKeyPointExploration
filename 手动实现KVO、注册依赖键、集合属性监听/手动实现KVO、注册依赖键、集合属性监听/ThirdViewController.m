//
//  ThirdViewController.m
//  手动实现KVO、注册依赖键、集合属性监听
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "ThirdViewController.h"
#import "PersonObject.h"
#import "BankObject2.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PersonObject    *personInstance = [[PersonObject alloc] init];
    BankObject2      *bankInstance = [[BankObject2 alloc] init];
    
    [bankInstance addObserver:personInstance forKeyPath:@"accountForBank" options:NSKeyValueObservingOptionNew context:NULL];
    
    bankInstance.accountBalance = 10;
    bankInstance.bankCodeEn = @"CCB";
    
    //卸载观察者
    [bankInstance removeObserver:personInstance forKeyPath:@"accountForBank"];
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
