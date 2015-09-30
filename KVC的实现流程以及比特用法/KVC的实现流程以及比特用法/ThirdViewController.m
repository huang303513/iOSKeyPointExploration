//
//  ThirdViewController.m
//  KVC的实现流程以及比特用法
//
//  Created by yifan on 15/9/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "ThirdViewController.h"
#import "HCDProduct.h"
#import "NSArray+HCDOperator.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self test1];
    
    //[self test2];
    
   // [self test3];
    
   // [self test4];
    
    [self test5];
}

-(void)test1{
    HCDProduct *product1 = [HCDProduct new];
    product1.price = 1.0;
    
    HCDProduct *product2 = [HCDProduct new];
    product2.price = 2.0;

    
    HCDProduct *product3 = [HCDProduct new];
    product3.price = 3.0;
    
    NSArray *products = @[product1,product2,product3];

    NSLog(@"avg:%@",[products valueForKeyPath:@"@avg.price"]);
    NSLog(@"count:%@",[products valueForKeyPath:@"@count.price"]);
    NSLog(@"max:%@",[products valueForKeyPath:@"@max.price"]);
    NSLog(@"min:%@",[products valueForKeyPath:@"@min.price"]);
    NSLog(@"sum:%@",[products valueForKeyPath:@"@sum.price"]);
}
//如果操作对象（集合/数组）内是NSNumber，可以这样写
-(void)test2{
    NSArray *arr = @[@1,@2,@3,@4,@5];
    NSLog(@"avg:%@",[arr valueForKeyPath:@"@avg.self"]);
    NSLog(@"count:%@",[arr valueForKeyPath:@"@count.self"]);
    NSLog(@"max:%@",[arr valueForKeyPath:@"@max.self"]);
    NSLog(@"min:%@",[arr valueForKeyPath:@"@min.self"]);
    NSLog(@"sum:%@",[arr valueForKeyPath:@"@sum.self"]);

}

-(void)test3{
    HCDProduct *product1 = [HCDProduct new];
    product1.name = @"huang";
    
    HCDProduct *product2 = [HCDProduct new];
    product2.name = @"huang";
    
    HCDProduct *product3 = [HCDProduct new];
    product3.name = @"huang";
    
    HCDProduct *product4 = [HCDProduct new];
    product4.name = @"cheng";
    
    HCDProduct *product5 = [HCDProduct new];
    product5.name = @"cheng";
    
    
    HCDProduct *product6 = [HCDProduct new];
    product6.name = @"du";

    
    NSArray *products = @[product1,product2,product3,product4,product5,product6];
    
    NSLog(@"unionOfObjects:%@",[products valueForKeyPath:@"@unionOfObjects.name"]);
    
    
    NSLog(@"distinctUnionOfObjects:%@",[products valueForKeyPath:@"@distinctUnionOfObjects.name"]);
}

/**
 @unionOfArrays:返回操作对象（且操作对象内对象必须是数组/集合）中数组/集合的所有对象，返回值为数组
 
 @distinctUnionOfArrays:返回操作对象（且操作对象内对象必须是数组/集合）中数组/集合的不同对象，返回值为数组
 
 @distinctUnionOfSets:返回操作对象（且操作对象内对象必须是数组/集合）中数组/集合的所有对象，返回值为集合
 */
-(void)test4{
    HCDProduct *product1 = [HCDProduct new];
    product1.name = @"huang";
    
    HCDProduct *product2 = [HCDProduct new];
    product2.name = @"huang";
    
    HCDProduct *product3 = [HCDProduct new];
    product3.name = @"huang";
    
    HCDProduct *product4 = [HCDProduct new];
    product4.name = @"cheng";
    
    HCDProduct *product5 = [HCDProduct new];
    product5.name = @"cheng";
    
    
    HCDProduct *product6 = [HCDProduct new];
    product6.name = @"du";
    
    
    NSSet *set1 = [NSSet setWithObjects:product1,product4   , nil];
    NSSet *set2 = [NSSet setWithObjects:product2,product5   , nil];
    NSSet *set3 = [NSSet setWithObjects:product3,product6   , nil];
    NSSet *set = [NSSet setWithObjects:set1,set2,set3, nil];
    
    NSArray *arr1 = @[product1,product4];
    NSArray *arr2 = @[product2,product5];
    NSArray *arr3 = @[product3,product6];
    NSArray *arr = @[arr1,arr2,arr3];
    
    
    
    NSLog(@"unionOfArrays:%@",[arr valueForKeyPath:@"@unionOfArrays.name"]);
    
    NSLog(@"distinctUnionOfArrays:%@",[arr valueForKeyPath:@"@distinctUnionOfArrays.name"]);
    
    NSLog(@"distinctUnionOfSets:%@",[set valueForKeyPath:@"@distinctUnionOfSets.name"]);
}
/**
 *  对数组自定义KVC操作。。。。。
 */
-(void)test5{
    NSArray *arr = @[@1,@2,@3,@4,@5];
    NSLog(@"%@",[arr valueForKeyPath:@"@huang.self"]);
}

@end
