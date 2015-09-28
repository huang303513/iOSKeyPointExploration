//
//  NSObject+HCDKeyValueObject.m
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "NSObject+HCDKeyValueObject.h"
#import "NSObject+Property.h"
#import "HCDProperty.h"
#import "HCDPropertyType.h"
@implementation NSObject (HCDKeyValueObject)
+ (instancetype)objectWithKeyValues:(id)keyValues{
    if (!keyValues) return nil;
    return [[[self alloc] init] setKeyValues:keyValues];
}

/**
 *  该方法从字典中需找要替换的key,参数是property的名字.如果字典中找不到对应的属性名,则不需要进行转换.
 *
 *  @param propertyName 属性的名字
 *
 *  @return 要么返回原始属性的名字、要么返回替代以后的名字
 */
+ (NSString *)propertyKey:(NSString *)propertyName{
    NSString *key;
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self replacedKeyFromPropertyName][propertyName];
    }
    return key?:propertyName;
}

- (instancetype)setKeyValues:(id)keyValues{
    keyValues = [keyValues JSONObject];
    NSArray *propertiesArray = [self.class properties];
    for (HCDProperty *property in propertiesArray) {
        HCDPropertyType *type = property.type;
        Class typeClass = type.typeClass;
        //获取对应属性的值
        //id value = [keyValues valueForKey:property.name];
        //先看是否实现了key得替换
        id value = [keyValues valueForKey:[self.class propertyKey:property.name]];

        if (!value) continue;
        //如果不是来自foundation框架的类并且不是基本数据类型 ,则递归。因为在这种情况下只有可能是自定义的类。所以我们可以递归解析自定义的类
        if (!type.isFromFoundation && typeClass) {
            value = [typeClass objectWithKeyValues:value];
            // 看该类是否实现了objectClassInArray方法
        }else if ([self.class respondsToSelector:@selector(objectClassInArray)]){
            id objectClass;
            //如果是NSString类型,例如@"statuses" : @"Status"
            objectClass = [self.class objectClassInArray][property.name];
            
            // 如果是NSString类型
            if ([objectClass isKindOfClass:[NSString class]]) {
                objectClass = NSClassFromString(objectClass);
            }
            //如果有值
            if (objectClass) {
                // 返回一个装了模型的数组
                value = [objectClass objectArrayWithKeyValuesArray:value];
            }
            
        }else if (type.isNumberType){
            NSString *oldValue = value;
            // 字符串->数字
            if ([value isKindOfClass:[NSString class]]){
                value = [[[NSNumberFormatter alloc] init] numberFromString:value];
                if (type.isBoolType) {
                    NSString *lower = [oldValue lowercaseString];
                    if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"true"] ) {
                        value = @YES;
                    } else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"]) {
                        value = @NO;
                    }
                }
            }
        }
        else{
            if (typeClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    if (type.isNumberType)
                        // NSNumber -> NSString
                        value = [value description];
                }else if ([value isKindOfClass:[NSURL class]]){
                    // NSURL -> NSString
                    value = [value absoluteString];
                }
            }
        }
        [self setValue:value forKey:property.name];
    }
    return self;
}


/**
 *  根据字典/JSON返回模型数组
 *
 *  @param keyValuesArray 字典/JSON数组
 *
 *  @return 模型数组
 */
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray{
    //,对数组里的每一个成员都进行字典转模型的方法.如果其中的成员不是自定义模型类,那么直接返回.
    if ([self isClassFromFoundation:self])
        return keyValuesArray;
    // 如果是json字符串,转成字典
    keyValuesArray = [keyValuesArray JSONObject];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    
    // 遍历
    for (NSDictionary *keyValues in keyValuesArray) {
        // 对其中的模型调用字典转模型方法,并添加到数组中返回
        id model;
        model = [self objectWithKeyValues:keyValues];
        if (model) {
            [modelArray addObject:model];
        }
    }
    
    return modelArray;
    
}


/**
 *  传入一个nsstring或者nsdata对象，返回对应的json数据。
 *
 *  @return 返回json数据
 */
- (id)JSONObject{
    id foundationObj;
    if ([self isKindOfClass:[NSString class]]) {
        foundationObj = [NSJSONSerialization JSONObjectWithData:[(NSString *)self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }else if ([self isKindOfClass:[NSData class]]){
        foundationObj = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    return foundationObj?:self;
}

@end
