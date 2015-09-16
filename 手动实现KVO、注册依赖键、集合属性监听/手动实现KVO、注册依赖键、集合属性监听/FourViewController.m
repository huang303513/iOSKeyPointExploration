//
//  FourViewController.m
//  手动实现KVO、注册依赖键、集合属性监听
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "FourViewController.h"
#import "PersonObject.h"
#import "BankObject3.h"
@interface FourViewController ()

@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BankObject3 *bankInstance = [[BankObject3 alloc] init];
    
    PersonObject    *personInstance = [[PersonObject alloc] init];
    [bankInstance addObserver:personInstance forKeyPath:@"departments" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    bankInstance.departments = [[NSMutableArray alloc] init];
    //连续两次激发kvo
    NSMutableArray *departments = [bankInstance mutableArrayValueForKey:@"departments"];
    [departments insertObject:@"departments 0" atIndex:0];
    [bankInstance removeObserver:personInstance forKeyPath:@"departments"];
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
