//
//  HCDText.m
//  KVC的实现流程以及比特用法
//
//  Created by yifan on 15/9/25.
//  Copyright © 2015年 黄成都. All rights reserved.
//

#import "HCDText.h"

@interface HCDText ()

@end


@implementation HCDText
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


-(void)set_object:(id)object{
    _object = object;
    NSLog(@"%s",__func__);

}
-(id)_object{
    NSLog(@"%s",__func__);
    return _object;
}

@end
