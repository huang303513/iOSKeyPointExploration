//
//  BankObject2.m
//  手动实现KVO、注册依赖键、集合属性监听
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "BankObject2.h"

@implementation BankObject2
//重写getter方法
- (NSString *)accountForBank {
    
    return [NSString stringWithFormat:@"account for %@ is %d", self.bankCodeEn, self.accountBalance];
}
//定义了这种依赖关系后，我们就需要以某种方式告诉KVO，当我们的被依赖属性修改时，会发送accountForBank属性被修改的通知。
//当两个属性之中的一个改变，就会激发kvo
+ (NSSet *)keyPathsForValuesAffectingAccountForBank {
    
    return [NSSet setWithObjects:@"accountBalance", @"bankCodeEn", nil];
}
@end
