//
//  FirstViewController.m
//  KVC的实现流程以及比特用法
//
//  Created by yifan on 15/9/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "FirstViewController.h"
#import "HCDText.h"
@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  HCDTest
     */
    //[self test1];
    //[self test2];
     [self test3];

}

/**
 *  KVC需要调用的函数
 */
-(void)test1{
    HCDText *test = [HCDText new];
    [test setValue:@"KVC" forKey:@"object"];
    [test valueForKey:@"object"];
    
    //    2015-09-25 15:38:21.144 KVC的实现流程以及比特用法[24887:275259] -[HCDText setValue:forKey:]
    //    2015-09-25 15:38:21.144 KVC的实现流程以及比特用法[24887:275259] -[HCDText setObject:]
    //    2015-09-25 15:38:21.145 KVC的实现流程以及比特用法[24887:275259] -[HCDText valueForKey:]
    //    2015-09-25 15:38:21.145 KVC的实现流程以及比特用法[24887:275259] -[HCDText object]
}

-(void)test2{
    HCDText *test = [HCDText new];
    [test setValue:@"KVC" forKey:@"_object"];
    [test valueForKey:@"_object"];
    
    //    2015-09-25 15:45:14.568 KVC的实现流程以及比特用法[25308:280989] -[HCDText setValue:forKey:]
    //    2015-09-25 15:45:14.568 KVC的实现流程以及比特用法[25308:280989] +[HCDText accessInstanceVariablesDirectly]
    //    2015-09-25 15:45:14.568 KVC的实现流程以及比特用法[25308:280989] -[HCDText valueForKey:]
    //    2015-09-25 15:45:14.569 KVC的实现流程以及比特用法[25308:280989] +[HCDText accessInstanceVariablesDirectly]
}


-(void)test3{
    HCDText *test = [HCDText new];
    [test setValue:@"KVC" forKey:@"_object"];
    [test valueForKey:@"_object"];
    NSLog(@"%@",test.object);
    //    2015-09-25 16:04:25.426 KVC的实现流程以及比特用法[26464:293769] -[HCDText setValue:forKey:]
    //    2015-09-25 16:04:25.427 KVC的实现流程以及比特用法[26464:293769] -[HCDText set_object:]
    //    2015-09-25 16:04:25.427 KVC的实现流程以及比特用法[26464:293769] -[HCDText valueForKey:]
    //    2015-09-25 16:04:25.427 KVC的实现流程以及比特用法[26464:293769] -[HCDText _object]
    //    2015-09-25 16:04:25.427 KVC的实现流程以及比特用法[26464:293769] -[HCDText object]
    //    2015-09-25 16:04:25.427 KVC的实现流程以及比特用法[26464:293769] KVC
}

@end
