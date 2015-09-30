//
//  NSArray+HCDOperator.m
//  KVC的实现流程以及比特用法
//
//  Created by yifan on 15/9/30.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "NSArray+HCDOperator.h"



@implementation NSArray (HCDOperator)
-(id)_huangForKeyPath:(NSString *)keyPath{
    NSInteger count = self.count;
    return [NSString stringWithFormat:@"%@,总共有%ld",@"hello 黄成都",(long)count];
}
@end
