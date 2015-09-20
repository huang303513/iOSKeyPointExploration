//
//  NSObject+Property.h
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)
/**
 *  这个方法返回对象包含的属性列表。列表中的每个对象包含名字和类型信息
 *
 *  @return 属性列表
 */
+ (NSArray *)properties;
/**
 *  判断是否是foundation框架的类
 *
 *  @param c 类名字
 *
 *  @return 返回布尔值
 */
+ (BOOL)isClassFromFoundation:(Class) c;
@end
