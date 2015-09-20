//
//  HCDProperty.h
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class HCDPropertyType;
/**
 *  这个类包含两个属性、一个是属性的名字、一个是属性的类型信息
 */
@interface HCDProperty : NSObject
/** 成员属性的名字 */
@property (nonatomic, readonly) NSString *name;
/** 成员属性的类型 */
@property (nonatomic, readonly) HCDPropertyType *type;
+ (instancetype)propertyWithProperty:(objc_property_t)property;
@end
