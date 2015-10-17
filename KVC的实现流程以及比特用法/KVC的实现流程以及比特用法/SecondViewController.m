//
//  SecondViewController.m
//  KVC的实现流程以及比特用法
//
//  Created by yifan on 15/9/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "SecondViewController.h"
#import "HCDText1.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**
     *  HCDTest1
     */
    //[self testHCDTest1_1];
    //[self testHCDTest1_2];
    [self testHCDTest1_3];

}

-(void)testHCDTest1_1{
    HCDText1 *test1 = [HCDText1 new];
    [test1 setValue:@"KVC" forKey:@"jack"];
    [test1 valueForKey:@"jack"];
    NSLog(@"%@",test1.object);
    
    //    2015-09-25 16:26:51.957 KVC的实现流程以及比特用法[27775:307546] -[HCDText1 setValue:forKey:]
    //    2015-09-25 16:26:51.959 KVC的实现流程以及比特用法[27775:307546] +[HCDText1 accessInstanceVariablesDirectly]
    //    2015-09-25 16:26:51.960 KVC的实现流程以及比特用法[27775:307546] +[HCDText1 accessInstanceVariablesDirectly]
    //    2015-09-25 16:26:51.960 KVC的实现流程以及比特用法[27775:307546] -[HCDText1 setValue:forUndefinedKey:]
    //    2015-09-25 16:26:51.961 KVC的实现流程以及比特用法[27775:307546] -[HCDText1 valueForKey:]
    //    2015-09-25 16:26:51.961 KVC的实现流程以及比特用法[27775:307546] +[HCDText1 accessInstanceVariablesDirectly]
    //    2015-09-25 16:26:51.962 KVC的实现流程以及比特用法[27775:307546] +[HCDText1 accessInstanceVariablesDirectly]
    //    2015-09-25 16:26:51.962 KVC的实现流程以及比特用法[27775:307546] -[HCDText1 valueForUndefinedKey:]
    //    2015-09-25 16:26:51.963 KVC的实现流程以及比特用法[27775:307546] -[HCDText1 object]
    //    2015-09-25 16:26:51.963 KVC的实现流程以及比特用法[27775:307546] hello jack
}


-(void)testHCDTest1_2{
    HCDText1 *test1 = [HCDText1 new];
    id value = @"KVV";
    NSString *key = @"object";
    NSError *error = nil;
    BOOL islegalValue = [test1 validateValue:&value forKey:key error:&error];
    if (islegalValue) {
        NSLog(@"键值匹配");
        [test1 setValue:value forKey:key];
    }else{
        NSLog(@"键值不匹配");
    }
}

-(void)testHCDTest1_3{
    HCDText1 *test1 = [HCDText1 new];
    [test1 setValue:nil forKey:@"num"];
    //[test1 setValue:@10 forKey:@"num"];
    NSLog(@"%d",test1.num);
}

@end
