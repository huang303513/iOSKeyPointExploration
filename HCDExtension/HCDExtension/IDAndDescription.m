//
//  IDAndDescription.m
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "IDAndDescription.h"

@implementation IDAndDescription


/**
 *  实际开发中,服务器通常返回一个字段名为id,或者description的JSON数据,而这两个名字在OC中有特殊含义,如上所示,在定义属性的时候并不能使用这类名称.这时属性名与字典key不再是直接对应的关系,需要加入一层转换.
 
 源码中key的替换也有几种方式选择,这里实现replacedKeyFromPropertyName这一方式.
 
 过程是在要替换key的模型类中实现replacedKeyFromPropertyName方法,返回一个原始key和更名的key对应的字典.replacedKeyFromPropertyName在protocol中声明
 *
 *  @return 
 */
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",//把服务器返回的id属性替换为ID类型
             @"Description" : @"description"
             };
}

@end
