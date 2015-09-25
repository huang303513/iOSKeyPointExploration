//
//  HCDText.m
//  KVC的实现流程以及比特用法
//
//  Created by yifan on 15/9/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HCDText1.h"

@interface HCDText1 ()

@end


@implementation HCDText1
//在同时实现setter和getter时，类中的@property不会自动生成带下滑线的成员变量（分类中是不能生成，注意区分），所以这里要手动生成。
@synthesize object = _object;

-(void)setObject:(id)object{
    _object = object;
    NSLog(@"%s",__func__);
}

-(id)object{
    NSLog(@"%s",__func__);
    return  _object;
}
/**
 *  这个方法默认返回为YES。当返回YES且key值不是object时，会自动匹配_object（返回NO不会进行匹配）
 *
 *  @return
 */
+(BOOL)accessInstanceVariablesDirectly{
     NSLog(@"%s",__func__);
    return  [super accessInstanceVariablesDirectly];
}

-(id)valueForKey:(NSString *)key{
     NSLog(@"%s",__func__);
    return  [super valueForKey:key];
}

-(void)setValue:(id)value forKey:(NSString *)key{
     NSLog(@"%s",__func__);
    [super setValue:value forKey:key];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%s",__func__);
    if ([key isEqualToString:@"jack"]) {
        _object = @"hello jack";
    }else{
        [super setValue:value forUndefinedKey:key];
    }
}
-(id)valueForUndefinedKey:(NSString *)key{
    NSLog(@"%s",__func__);

    if ([key isEqualToString:@"jack"]) {
        return _object = @"hello jack";
    }else{
        return [super valueForUndefinedKey:key];
    }
}


-(void)setNilValueForKey:(NSString *)key{
    NSLog(@"%s",__func__);
    NSLog(@"%@不能赋值为nil",key);
}

/**
 *  如果实现下面两个方法。则不会运行上面两个方法
 */
//-(void)setJack:(id)object{
//    NSLog(@"%s",__func__);
//    _object = @"hello jack";
//}
//-(id)jack{
//    NSLog(@"%s",__func__);
//    return  _object;
//}
@end
