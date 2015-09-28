//
//  HCDProperty.m
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDProperty.h"
#import "HCDPropertyType.h"
@implementation HCDProperty
/**
 *  初始化一个对象
 *
 *  @param property 类型信息
 *
 *  @return 返回自定义的类型信息
 */
+ (instancetype)propertyWithProperty:(objc_property_t)property{
    return  [[HCDProperty alloc] initWithProperty:property];
}


- (instancetype)initWithProperty:(objc_property_t)property{
    if (self = [super init]) {
        _name = @(property_getName(property));
        
        _type = [HCDPropertyType propertyTypeWithAttributeString:@(property_getAttributes(property))];;
    }
    return self;
}
@end
