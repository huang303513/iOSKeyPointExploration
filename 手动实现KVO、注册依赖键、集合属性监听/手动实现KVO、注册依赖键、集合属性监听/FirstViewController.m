//
//  FirstViewController.m
//  手动实现KVO、注册依赖键、集合属性监听
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "FirstViewController.h"
#import "PersonObject.h"
#import "BankObject.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PersonObject *personInstance = [[PersonObject alloc] init];
    BankObject *bankInstance = [[BankObject alloc] init];
    
    [bankInstance addObserver:personInstance forKeyPath:@"accountBalance" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    [bankInstance addObserver:personInstance forKeyPath:@"accountBalance" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    [bankInstance addObserver:personInstance forKeyPath:@"accountBalance" options:NSKeyValueObservingOptionNew context:"person instance"];
    [bankInstance addObserver:personInstance forKeyPath:@"accountBalance" options:NSKeyValueObservingOptionNew context:"person instance 2"];
    
    bankInstance.accountBalance = 10;
    
    //一个良好的实践是在观察者不再需要监听属性变化时，必须调用removeObserver:forKeyPath:或removeObserver:forKeyPath:context:方法来移除观察者，
    //在对象被被卸载之前、需要手动移除观察者。
    [bankInstance removeObserver:personInstance forKeyPath:@"accountBalance"];
    [bankInstance removeObserver:personInstance forKeyPath:@"accountBalance"];
    [bankInstance removeObserver:personInstance forKeyPath:@"accountBalance" context:NULL];
    [bankInstance removeObserver:personInstance forKeyPath:@"accountBalance" context:NULL];
}
-(void)dealloc{
    

    
}

@end
