//
//  HCDPropertyType.m
//  HCDExtension
//
//  Created by 黄成都 on 15/9/20.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDPropertyType.h"
#import "HCDExtensionConst.h"
#import "HCDProperty.h"
#import "NSObject+Property.h"
@implementation HCDPropertyType
/**
 *  用于缓存一些常用类型的type，避免多次调用
 */
static NSMutableDictionary *cachedTypes_;
+ (void)load
{
    cachedTypes_ = [NSMutableDictionary dictionary];
}

+ (instancetype)propertyTypeWithAttributeString:(NSString *)string{
    return [[HCDPropertyType alloc] initWithTypeString:string];
}

- (instancetype)initWithTypeString:(NSString *)string
{
    NSUInteger loc = 1;
    NSUInteger len = [string rangeOfString:@","].location - loc;
    NSString *typeCode = [string substringWithRange:NSMakeRange(loc, len)];
    //如果以前没有缓存对应type。。则初始化。
    if (!cachedTypes_[typeCode])
    {
       // NSLog(@"%@",typeCode);
        self = [super init];
        [self getTypeCode:typeCode];
        cachedTypes_[typeCode] = self;
    }

    return self;
}
/**
 *  得到具体的类型
 *
 *  @param code 得到具体的类型信息
 */
- (void)getTypeCode:(NSString *)code
{
    //NSLog(@"%@",code);
    if ([code isEqualToString:MJPropertyTypeId]) {
        _idType = YES;
    } else if (code.length > 3 && [code hasPrefix:@"@\""]) {
        // 去掉@"和"，截取中间的类型名称
        _code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(_code);
        _numberType = (_typeClass == [NSNumber class] || [_typeClass isSubclassOfClass:[NSNumber class]]);
        //
        _fromFoundation = [NSObject isClassFromFoundation:_typeClass];
    }
    // 是否为数字类型
    NSString *lowerCode = code.lowercaseString;
    NSArray *numberTypes = @[MJPropertyTypeInt, MJPropertyTypeShort, MJPropertyTypeBOOL1, MJPropertyTypeBOOL2, MJPropertyTypeFloat, MJPropertyTypeDouble, MJPropertyTypeLong, MJPropertyTypeChar];
    //boole类型是number类型的一种。
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        
        if ([lowerCode isEqualToString:MJPropertyTypeBOOL1]
            || [lowerCode isEqualToString:MJPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
}

@end
