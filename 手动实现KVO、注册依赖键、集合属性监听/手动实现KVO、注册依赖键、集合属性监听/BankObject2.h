//
//  BankObject2.h
//  手动实现KVO、注册依赖键、集合属性监听
//
//  Created by 黄成都 on 15/9/16.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankObject2 : NSObject
@property (nonatomic, assign) int accountBalance;
@property (nonatomic, copy) NSString *bankCodeEn;
@property (nonatomic, strong) NSMutableArray *departments;
//这个属性的值依赖与其他属性
@property (nonatomic, copy) NSString *accountForBank;
@end
